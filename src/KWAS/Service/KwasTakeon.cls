Class KWAS.Service.KwasTakeon Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Property Delimiter As %String;

Parameter SETTINGS = "Delimiter";

Method OnProcessInput(pInput As %FileCharacterStream, Output pOutput As %RegisteredObject) As %Status
{
	Set $ZT = "trap"
	$$$LOGINFO("Beginning KWAS dataload takeon")
	Set counter = 1
	Set delim = ..Delimiter
	while 'pInput.AtEnd {
     set line=pInput.ReadLine()
     If line = "***BOF***" { Continue }
     If line = "***EOF***" { Quit }
     Set obj = ##class(KWAS.Patient.Admission).%New()
     Set obj.NHSNumber = $p(line,delim,1)
     Set obj.DateOfBirth = $P(line,delim,2)
     Set obj.Forename = $p(line,delim,3)
     Set obj.Surname = $p(line,delim,4)
     Set obj.Ward = $p(line,delim,5)
     Set obj.HospitalNumber = $p(line,delim,6)
     Set obj.AdmissionDate = $p(line,delim,7)
     Set obj.Consultant = $p(line,delim,8)
     Set obj.ConsultantName = $p(line,delim,9)
     Set obj.Active = 1
     Set obj.CreationDateTime = $ZDATETIME($H,3,1)
     Set obj.LastEditDateTime = $ZDATETIME($H,3,1)
     Set ok = obj.%Save()
     If $$$ISERR(ok) { $$$LOGERROR("Error adding KWAS Patient record on upload takeon.  Error: "_$System.Status.GetErrorText(ok)) }
	 Else { $$$LOGINFO("patient "_$piece(line,delim,6)_" loaded successfully") }
	 Set counter = counter+1
	}
	$$$LOGINFO("Patients finished loading onto KWAS file")
	Set $ZT=""
	Quit $$$OK
	
trap
 $$$LOGERROR("Error loading for record No "_counter_" - "_$ZERROR)
 Set $ECODE=""
 Set $ZT=""
 Quit $$$OK
}

}
