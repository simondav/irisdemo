Include EnsHL7

Class KWAS.Patient.Admission Extends %Persistent
{

Property HospitalNumber As %String [ Required ];

Index HospitalNumberIndex On HospitalNumber [ Unique ];

Property NHSNumber As %String;

Property Surname As %String;

Property Forename As %String;

Property DateOfBirth As %String;

Property Active As %Boolean [ Required ];

Index ActiveIndex On Active;

Property Ward As %String [ Required ];

Property Consultant As %String [ Required ];

Property ConsultantName As %String;

Property AdmissionDate As %Date [ Required ];

Property TransferDate As %Date;

Property DischargeDate As %Date;

Property HomeLeave As %Boolean;

Property CreationDateTime As %TimeStamp;

Property LastEditDateTime As %TimeStamp;

ClassMethod LockTable(Output mess As %String) As %Status
{
  Set %status = $$$OK
  &sql(LOCK KWAS_Patient.Admission IN EXCLUSIVE MODE WAIT 4) 
  If SQLCODE=0 { 
    Set mess="KWAS Patient Admissions Table Locked"
    $$$LOGINFO("*** "_mess_" ***")
  }
  ElseIf SQLCODE=-110 { 
  	Set mess="KWAS Patient Table is locked by another process "_%msg
  	$$$LOGERROR("*** "_mess_" ***")
  	Set %status=$$$ERROR($$$GeneralError,mess)
  }
  Else { 
  	Set mess="Unexpected LOCK error for KWAS Patient Table: "_SQLCODE_" "_%msg 
  	$$$LOGERROR("*** "_mess_" ***")
  	Set %status=$$$ERROR($$$GeneralError,mess)
  }
  Quit %status
}

ClassMethod unLockTable(Output mess As %String) As %Status
{
  Set %status = $$$OK
  &sql(UNLOCK KWAS_Patient.Admission IN EXCLUSIVE MODE) 
  If SQLCODE=0 { 
  	Set mess="KWAS Patient Admissions Table unlocked"
    $$$LOGINFO("*** "_mess_" ***")
  }
  Else { 
  	Set mess="Unexpected UNLOCK: "_SQLCODE_" "_%msg
  	$$$LOGERROR("*** "_mess_" ***")
  	Set %status=$$$ERROR($$$GeneralError,mess)
  }
  Quit %status
}

Storage Default
{
<Data name="AdmissionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>HospitalNumber</Value>
</Value>
<Value name="3">
<Value>Active</Value>
</Value>
<Value name="4">
<Value>Ward</Value>
</Value>
<Value name="5">
<Value>AdmissionDate</Value>
</Value>
<Value name="6">
<Value>TransferDate</Value>
</Value>
<Value name="7">
<Value>TransferTime</Value>
</Value>
<Value name="8">
<Value>DischargeDate</Value>
</Value>
<Value name="9">
<Value>DischargeTime</Value>
</Value>
<Value name="10">
<Value>Consultant</Value>
</Value>
<Value name="11">
<Value>ConsultantName</Value>
</Value>
<Value name="12">
<Value>NHSNumber</Value>
</Value>
<Value name="13">
<Value>Surname</Value>
</Value>
<Value name="14">
<Value>Forename</Value>
</Value>
<Value name="15">
<Value>DateOfBirth</Value>
</Value>
<Value name="16">
<Value>HomeLeave</Value>
</Value>
<Value name="17">
<Value>CreationDateTime</Value>
</Value>
<Value name="18">
<Value>LastEditDateTime</Value>
</Value>
</Data>
<DataLocation>^KWAS.Patient.AdmissionD</DataLocation>
<DefaultData>AdmissionDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^KWAS.Patient.AdmissionD</IdLocation>
<IndexLocation>^KWAS.Patient.AdmissionI</IndexLocation>
<StreamLocation>^KWAS.Patient.AdmissionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
