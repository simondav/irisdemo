Class KWAS.Operation.KWASFileOutput Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Property Adapter As EnsLib.File.OutboundAdapter;

Property Delimiter As %String;

Property Filename As %String;

Parameter SETTINGS = "Delimiter,Filename";

Parameter INVOCATION = "Queue";

/// This user callback method is called via initConfig() from %OnNew() or in the case of SOAP Services from OnPreSOAP()
Method OnInit() As %Status
{
	Set ..Adapter.LineTerminator=$C(13,10)
	Quit $$$OK
}

Method OutputKWAS(pRequest As Ens.Request, Output pResponse As Ens.StringResponse) As %Status
{
 Set %sc=$$$OK
 try {
 	; try to lock KWAS Patient table
 	Set %sc=##class(KWAS.Patient.Admission).LockTable(.mess)
 	If $$$ISERR(%sc) {
		Set %sc=..CreateEmailAlert(mess)
 		Quit 
	}
	Set delim = ..Delimiter
	$$$LOGINFO("*** Generating KWAS file ***")
 	Set pLine = "***BOF***"
 	Set tFileName=..Adapter.CreateTimestamp(..Filename,"%f_%D_%R")
	Set tFileName=tFileName_".txt"
	; write header line to file
 	Set sc=..Adapter.PutLine(tFileName,pLine)
 	&SQL(DECLARE s1 CURSOR FOR select 
  	 ID, 
   	 HospitalNumber,
   	 NHSNumber,
   	 Surname,
     Forename,
   	 DateOfBirth,
  	 Ward,
   	 Consultant,
   	 ConsultantName,
   	 AdmissionDate
    into
   	 :ID,
   	 :HospitalNumber,
   	 :NHSNumber,
   	 :Surname,
   	 :Forename,
   	 :DOB,
     :Ward,
   	 :Consultant,
  	 :ConsultantName,
  	 :AdmissionDate
  	from KWAS_Patient.Admission where Active = 1)
	
 	&sql(OPEN s1)
 	&sql(FETCH s1)
  
 	For {
   	 	If SQLCODE = 0 {
			Set pLine = NHSNumber_delim_DOB_delim_Forename_delim_Surname_delim_Ward
			Set pLine = pLine_delim_HospitalNumber_delim_AdmissionDate_delim_Consultant_delim_ConsultantName
			; write each patient to file
			Set sc=..Adapter.PutLine(tFileName,pLine)
			&sql(FETCH s1)
   		}
    	Else {     
	    	Set pLine = "***EOF***"
	    	; write footer line to file
 			Set sc=..Adapter.PutLine(tFileName,pLine)
 			Quit 	   
    	}

	}
 	&sql(CLOSE s1)
	Set pResponse=##class(Ens.StringResponse).%New()
	Set pResponse.StringValue="done"
	$$$LOGINFO("*** Completion of KWAS file generation ***")
 	; unlock the KWAS Patient table
 	Set %sc=##class(KWAS.Patient.Admission).unLockTable(.mess)
 	If $$$ISERR(%sc) { 
 		Set %sc=..CreateEmailAlert(mess)
 	}
 }
 catch errobj {
	 $$$LOGERROR("Error in OutputKWAS(): "_errobj.Name_", Location = "_errobj.Location)
	 Set %sc=##class(KWAS.Patient.Admission).unLockTable(.mess)
	 Set %sc=..CreateEmailAlert("KWAS File Output has crashed and failed to complete")
 }
 Quit %sc
}

Method CreateEmailAlert(mess As %String) As %Status
{
	Set alertObj=##class(Ens.AlertRequest).%New()
	Set alertObj.AlertText = mess
 	Set tStatus = ..SendRequestAsync("EmailAlert",alertObj)
 	Quit tStatus
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.Request"> 
		<Method>OutputKWAS</Method>
	</MapItem>
</MapItems>
}

}
