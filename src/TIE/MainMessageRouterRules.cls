/// Version: 1.0
/// Specification: Specification: NHS2-MSG-TCS-26820-001-EDIS McKEsson TotalCare PAS Ensemble Adaptor-v1.7.xlsm
/// 
/// Comments:
/// Passed module testing - ready for deployment testing.
/// Note separate target file operations needed to make change to subcomponent separator character.
/// Change history (most recent first):
/// Vers   Date   Who Reasons for change
/// 1.0  03/09/12 JKJ Baselined following successful witnessed module testing.
/// 0.1  17/07/12 JKJ Creation from spec. based on TIE Template
Class TIE.MainMessageRouterRules Extends Ens.Rule.Definition [ ProcedureBlock ]
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssistCompatible";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="TIE.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="Medway24"></constraint>
<when condition="(HL7.{MSH:MessageType.messagetype} = &quot;ADT&quot; &amp;&amp; Exists(&quot;KwasER&quot;,HL7.{EVN:EventReasonCode}))">
<send transform="" target="KWASUpdate"></send>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="Medway24"></constraint>
<when condition="Exists(&quot;MaternityTE&quot;,HL7.{MSH:MessageType.triggerevent}) ">
<send transform="" target="GuardianMessageRouter"></send>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="(StartsWith(HL7.Name,&quot;ADT_A04&quot;))">
<send transform="" target="EDISMessageRouter"></send>
<return></return>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="(StartsWith(HL7.Name,&quot;ADT_A08&quot;))">
<send transform="" target="EDISMessageRouter"></send>
<return></return>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="(StartsWith(HL7.Name,&quot;ADT_A28&quot;))">
<send transform="" target="TotalCAREMessageRouter"></send>
<return></return>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="(StartsWith(HL7.Name,&quot;ADT_A31&quot;))">
<send transform="" target="TotalCAREMessageRouter"></send>
<return></return>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="(StartsWith(HL7.Name,&quot;ADT_A34&quot;))">
<send transform="" target="TotalCAREMessageRouter"></send>
<return></return>
</when>
</rule>
<rule name="" disabled="false">
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="(StartsWith(HL7.Name,&quot;MFN_M02&quot;))">
<send transform="" target="TotalCAREMessageRouter"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
