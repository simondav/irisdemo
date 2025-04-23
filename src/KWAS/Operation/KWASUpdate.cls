Class KWAS.Operation.KWASUpdate Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
	<MapItem MessageType="EnsLib.HL7.Message"> 
		<Method>Update</Method>
	</MapItem>
</MapItems>
}

Method Update(message As EnsLib.HL7.Message, Output pResponse As EnsLib.HL7.Message) As %Status
{
	Set %sc = $$$OK
	try {
		Set eventType=message.GetValueAt("EVN:1")
		Set evnCode=message.GetValueAt("EVN:4")
		;
		If evnCode=100 {
			Set numbersets=message.GetValueAt("PID:PatientIdentifierList()")
			//Set hospNumber = message.GetValueAt("PID:PatientIdentifierList(1).ID")
			Set hospNumber = ##class(KWAS.Patient.Functions).FindUN(numbersets)
			; test if a record already exists for this unique patient hospital number
			Set success = ##class(KWAS.Patient.Admission).HospitalNumberIndexExists(hospNumber,.id)
			If success {
				; rejected flag is to be set to 1 if it encounters a condition which means that
				; this admission should not be processed
				Set rejected = 0
				; for loop is for concurrency - check if locked already, if not proceed, if so keep looping
				For {
					Set obj = ##class(KWAS.Patient.Admission).%OpenId(id,4,.sc)
					; if not locked then.....
					If obj'="",sc {
						Set dischargeDateH = $extract(obj.DischargeDate,1,8)  ; convert date to cache internal format
						; get the production setting for keeping inactive KWAS records
						Set NoOfDaysToKeepDischarges = $Get($$$ConfigProdSetting("NoOfDaysToKeepKWASRecords"))
						If 'obj.Active {
							If obj.DischargeDate '= "" {
								Set del = ##class(KWAS.Patient.Admission).%DeleteId(id)			
								$$$LOGINFO("Inactive record for patient "_hospNumber_" deleted as new admission has occurred")
								Quit
								; it it outside the number of days to keep inactive records
								//If (+$H-NoOfDaysToKeepDischarges)>$ZDATEH(dischargeDateH,15) {			

								//}
								//Else {
								//	$$$LOGINFO("Admission record for patient "_hospNumber_" on KWAS has been rejected because patient has not been discharged for more than "_NoOfDaysToKeepDischarges)
								//	Set rejected = 1
								//	Quit
								//}
							}
							; patient can be on home leave whilst inactive
							ElseIf obj.HomeLeave {
								$$$LOGINFO("Admission record for patient "_hospNumber_" on KWAS has been rejected because patient cannot be admitted again whilst still on home leave")
								Set rejected = 1
								Quit
							}
							Quit
						}
						Else {
							$$$LOGINFO("Admission record for patient "_hospNumber_" on KWAS has been rejected because patient cannot be admitted whilst still in ward "_obj.Ward)
							Set rejected = 1
							Quit
						}
					}
				}
				If rejected { 
					Kill obj   ;
					Set %sc=success 
				}
				Else {	
					Set %sc = ..CreateAdmission(message)
					If %sc { Kill obj }  ; get rid of the lock
				}
			} 
			Else {
				; if not existing patient then just process...
				Set %sc = ..CreateAdmission(message)
			}

		}
		Else {
			Set amend=0
			If eventType = "A40" {
				Set hospNumber = message.GetValueAt("PIDgrp(1).PID:PatientIdentifierList(1).ID")
			}
			Else {
				Set hospNumber = message.GetValueAt("PID:PatientIdentifierList(1).ID")
			}
			&sql(select ID into :id from KWAS_Patient.Admission where HospitalNumber = :hospNumber)
			; if sql query returns an error then process it
			If SQLCODE '= 0 {
				If SQLCODE = 100 {
					$$$LOGINFO("Patient Code "_hospNumber_" not on patient admission table")
					Quit
				}
				Else {
					$$$LOGINFO("SQL Error "_ SQLCODE_" on KWAS Update")
					Quit
				}
			}
			For  {
				Set obj=##class(KWAS.Patient.Admission).%OpenId(id,4,.sc)
				; test for locking
				If obj'="",+sc { 
					; transfers
					If evnCode=120 {
						Set obj.Ward = message.GetValueAt("PV1:3.1")
						Set amend=1
					}
					ElseIf evnCode=130 {
						Set obj.Consultant = message.GetValueAt("PV1:9.1")
						Set obj.ConsultantName = ..GetConsultantName(message)
						Set amend=1
					}
					ElseIf evnCode=140 {
						Set obj.Active = 0
						Set obj.DischargeDate = $Extract(message.GetValueAt("PV1:DischargeDateTime"),1,8)
						Set amend=1
					}
					ElseIf evnCode=101 {
						Set obj.AdmissionDate = $Extract(message.GetValueAt("PV1:44"),1,8)
						Set amend=1
					}
					ElseIf evnCode=102 {
						Set obj.Active=0
						Set amend=1
					}
					ElseIf evnCode=122 {
						Set obj.Ward = message.GetValueAt("PV1:3.1")
						Set amend=1
					}
					ElseIf evnCode=132 {
						Set obj.Consultant = message.GetValueAt("PV1:9.1")
						Set obj.ConsultantName = ..GetConsultantName(message)
						Set amend=1
					}
					ElseIf evnCode=142 {
						Set obj.Active=1
						Set obj.DischargeDate=""
						Set amend=1
					}
					ElseIf evnCode=150 {
						Set obj.Active = 0
						Set obj.HomeLeave = 1
						Set amend=1
					}
					ElseIf evnCode=151,obj.HomeLeave = 1 {
						Set obj.Active = 1
						Set obj.HomeLeave = 0
						Set amend=1
					}
					ElseIf evnCode=152,obj.HomeLeave = 1 {
						Set obj.Active = 1
						Set obj.HomeLeave = 0
						Set amend=1
					}	
					If amend { 
						Set obj.LastEditDateTime = $ZDATETIME($H,3,1) 
						Set %sc=obj.%Save()
						If $$$ISERR(%sc) { $$$LOGERROR("Error saving KWAS Patient record.  Error: "_$System.Status.GetErrorText(%sc)) }
					}
					Kill obj
					Quit
				}	
			}
		}
		
	}
	Catch errobj{
		$$$LOGERROR("Error in KWAS update "_errobj.Name_", Location = "_errobj.Location_", Data = "_errobj.Data)
	}
	Quit %sc
}

ClassMethod GetConsultantName(message As EnsLib.HL7.Message) As %String
{
	Set conTitle = message.GetValueAt("PV1:9.6")
	Set conFName = message.GetValueAt("PV1:9.3")
	Set conMName = message.GetValueAt("PV1:9.4")
	Set conSName = message.GetValueAt("PV1:9.2")
	Set consultantName = conTitle_" "_conFName_" "_conMName_" "_conSName
	Quit consultantName
}

Method CreateAdmission(message As %String) As %Status
{
	Set ok=""
	try {
		Set numbersets=message.GetValueAt("PID:PatientIdentifierList()")
		Set NHSNo = ##class(KWAS.Patient.Functions).FindNHS(numbersets)
		Set hospNumber = ##class(KWAS.Patient.Functions).FindUN(numbersets)
		; go through through the whole patient list to get the NHS number
		//For i = 1:1:$Length(numbersets,"~") {
		//	Set number=message.GetValueAt("PID:PatientIdentifierList("_i_").ID")
		//	If message.GetValueAt("PID:PatientIdentifierList("_i_").identifiertypecodeID") = "NH",number '= "" {
		//		Set NHSNo = number
		//	}
		//	Else {
		//		Set hospNumber = number
		//	}
		//}
		Set obj=##class(KWAS.Patient.Admission).%New()
		Set obj.HospitalNumber = hospNumber
		Set obj.NHSNumber = NHSNo
		Set obj.Surname = message.GetValueAt("PID:5.1")
		Set obj.Forename = message.GetValueAt("PID:5.2")
		Set obj.DateOfBirth = message.GetValueAt("PID:7")
		Set obj.AdmissionDate = $extract(message.GetValueAt("PV1:44"),1,8)
		Set obj.Ward = message.GetValueAt("PV1:3.1")
		Set obj.Consultant = message.GetValueAt("PV1:9.1")
		Set obj.Active = 1
		Set obj.ConsultantName = ..GetConsultantName(message)
		Set obj.CreationDateTime = $ZDATETIME($H,3,1)
		Set ok = obj.%Save()
		If $$$ISERR(ok) { $$$LOGERROR("Error saving KWAS Patient record.  Error: "_$System.Status.GetErrorText(ok)) }	
	}
	Catch errobj{
		throw errobj
	}	
	Quit ok
}

}
