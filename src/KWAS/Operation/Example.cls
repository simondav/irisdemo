Class KWAS.Operation.Example Extends %RegisteredObject
{

/// test method for debugger
ClassMethod Test(mess As %String) As %Status
{
    s test=$g(mess,"hello")
    w test
    s xeros=5+7
    w xeros
    s t=$e(test,1,2)
    s x=$p("kkj*jkjk*jkjk","*",2)
    write x
    Quit 1
}

}
