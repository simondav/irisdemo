Include EnsHL7

Class KWAS.KWASTaskLauncher Extends %SYS.Task.Definition
{

/// This method is responsible for executing the task.<br>
/// At the scheduled time, the Task Manager creates an instance of this object,
/// sets any property values using the stored "settings" for the task, and then
/// invokes this method to execute the task.<br>
/// In order to execute a real task, override this method in a subclass.
Method OnTask() As %Status
{
 Set tSC=$$$OK
	try {
		Set tService = ##class(Ens.Director).CreateBusinessService("KWASOutputRequest",.bs)
		If ($IsObject(bs)) {
	 		Set tSC = bs.ProcessInput()
		}
		K bs
	}
	catch errobj{
		$$$LOGERROR("Error in KWAS Task Launcher "_errobj.Name)
	}		
 Quit tSC
}

}
