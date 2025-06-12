Class SCD.User Extends %Persistent
{

Property Name As %String [ Required ];

Storage Default
{
<Data name="UserDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^SCD.UserD</DataLocation>
<DefaultData>UserDefaultData</DefaultData>
<IdLocation>^SCD.UserD</IdLocation>
<IndexLocation>^SCD.UserI</IndexLocation>
<StreamLocation>^SCD.UserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
