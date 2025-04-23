Include EnsHL7

Class KWAS.HouseCleaningTaskLauncher Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
	Set tSC=$$$OK
	try {
		Set tService = ##class(Ens.Director).CreateBusinessService("KWASHouseCleaningService",.bs)
		If $$$ISERR(tService) {
			$$$LOGERROR("KWAS Housecleaning has failed to start")
		}
		If ($IsObject(bs)) {
	 		Set tSC = bs.ProcessInput()
		}
		K bs
	}
	catch errobj {
		$$$LOGERROR("Error in KWAS House Cleaning Task Launcher "_errobj.Name)
	}
	Quit tSC
}

}
