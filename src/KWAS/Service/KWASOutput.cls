Class KWAS.Service.KWASOutput Extends Ens.BusinessService
{

ClassMethod OnGetConnections(Output pArray As %String, item As Ens.Config.Item)
{
	
	Set pArray(1)="KWASFileOutput"
}

Method OnProcessInput(pInput As Ens.Request, pOutput As Ens.Response) As %Status
{
 ;
 Set tSC=$$$OK
 try {
	Set pRequest=##class(Ens.Request).%New()
	$$$LOGINFO("Submitting request for KWAS File output generation")
	Set tSC= ..SendRequestAsync("KWASFileOutput",pRequest) 
	If $$$ISERR(tSC) { $$$LOGERROR(tSC) }
 }
 ;
 catch errobj{
	$$$LOGERROR("Error in KWAS File submission output request "_errobj.Name)	
 }
	;
 Quit tSC
}

}
