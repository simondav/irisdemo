Class KWAS.Service.KWASHouseCleaning Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
 Set %sc=$$$OK
 try {
 	; try to lock KWAS Patient table
 	Set %sc=##class(KWAS.Patient.Admission).LockTable(.mess)
 	If $$$ISERR(%sc) {
	 	Set %sc=..CreateEmailAlert(mess)
 		Quit 
	}
	;
	$$$LOGINFO("*** Beginning KWAS Daily House Cleaning ***")
	Set NoOfDaysToKeepOldRecs = $Get($$$ConfigProdSetting("NoOfDaysToKeepKWASRecords"))
	&SQL(DECLARE s1 CURSOR FOR select 
  	 ID, 
  	 HospitalNumber,
  	 DischargeDate
  	into
  	 :ID,
  	 :HospNumber,
  	 :DischargeDate
  	from KWAS_Patient.Admission where Active = 0 AND (Homeleave != 1 OR Homeleave IS NULL))
			
	&sql(OPEN s1)
 	&sql(FETCH s1)
 	
 	while SQLCODE = 0 {
		Set dischargeDateH = $extract(DischargeDate,1,8)
		; for discharges check elapsed days since discharge against parameter
		If DischargeDate '= "",(+$H-NoOfDaysToKeepOldRecs)>$ZDATEH(dischargeDateH,15) {
			Set del = ##class(KWAS.Patient.Admission).%DeleteId(ID)
			$$$TRACE("KWAS record deleted for patient "_HospNumber_" as discharged")
		}
		; everything else should be a cancelled admission which can simply be deleted
		Else {
			Set del = ##class(KWAS.Patient.Admission).%DeleteId(ID)
			$$$TRACE("KWAS record deleted for patient "_HospNumber_" as admission cancelled")
		}
		&sql(FETCH s1)
	}
	&sql(CLOSE s1)
	;
	$$$LOGINFO("*** End of KWAS Daily House Cleaning ***")
 	; unlock the KWAS Patient table
 	Set %sc=##class(KWAS.Patient.Admission).unLockTable(.mess)
 	If $$$ISERR(%sc) { 
 		$$$LOGERROR("KWAS File Output process has failed to unlock KWAS.Patient.Admission table")
 	}	

 }
 catch errobj {
	 $$$LOGERROR("Error in KWAS daily house cleaning: "_errobj.Name_", Location = "_errobj.Location)
	 Set %sc=##class(KWAS.Patient.Admission).unLockTable(.mess)
	 Set %sc=..CreateEmailAlert("KWAS Daily Housecleaning has crashed and failed to complete")
 }
	;	
 Quit %sc
}

Method CreateEmailAlert(mess As %String) As %Status
{
	Set alertObj=##class(Ens.AlertRequest).%New()
	Set alertObj.AlertText = mess
 	Set tStatus = ..SendRequestAsync("EmailAlert",alertObj)
 	Quit tStatus
}

}
