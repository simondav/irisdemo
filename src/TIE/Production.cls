Class TIE.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="TIE.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description>TIE Production</Description>
  <ActorPoolSize>5</ActorPoolSize>
  <Setting Target="Adapter" Name="NoOfDaysToKeepKWASRecords">0</Setting>
  <Item Name="CheckSequence" Category="BaseTie" ClassName="EnsLib.HL7.SequenceManager" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="Check sequence numbers and Message Control IDs - MSH:13 and MSH:10 for dups, gaps, lates" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="EnableDuplicatedMessageCheck">1</Setting>
    <Setting Target="Host" Name="PerformSequenceNumberCheckOn">None</Setting>
    <Setting Target="Host" Name="PerformOutputTransformationOn">None</Setting>
    <Setting Target="Host" Name="OutputSequenceNumberIndexField">Auto</Setting>
    <Setting Target="Host" Name="OutputTargetConfigNames">MainMessageRouter</Setting>
    <Setting Target="Host" Name="MessageWaitTimeout">200</Setting>
    <Setting Target="Host" Name="PassThroughMessageTypes">QBP_Q21,QBP_Q22,RSP_K21,RSP_K22,ACK</Setting>
    <Setting Target="Host" Name="OutOfSequenceMessageTarget">OutOfSequenceOperation</Setting>
    <Setting Target="Host" Name="DuplicatedMessageTarget">DuplicateMessageOperation</Setting>
    <Setting Target="Host" Name="OutputFacilityApplication"></Setting>
    <Setting Target="Host" Name="MessageResendableTimeWindow">300</Setting>
    <Setting Target="Host" Name="LargeGapSize">100</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
  </Item>
  <Item Name="MainMessageRouter" Category="BaseTie" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="Primary Message Router" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">ODS:TIE:EDIS24</Setting>
    <Setting Target="Host" Name="AckType">Commit</Setting>
    <Setting Target="Host" Name="NackCode">Error</Setting>
    <Setting Target="Host" Name="AddNackERR">0</Setting>
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">TIE.MainMessageRouterRules</Setting>
    <Setting Target="Host" Name="AlertOnBadMessage">1</Setting>
    <Setting Target="Host" Name="BadMessageHandler"></Setting>
    <Setting Target="Host" Name="ResponseFrom"></Setting>
    <Setting Target="Host" Name="ResponseTargetConfigNames">MainAckMessageRouter</Setting>
    <Setting Target="Host" Name="ResponseTimeout">-1</Setting>
    <Setting Target="Host" Name="ForceSyncSend">0</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
  </Item>
  <Item Name="Input From CSCA" Category="BaseTie" ClassName="EnsLib.HL7.Service.HTTPService" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="HTTP messages from CSCA" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">CheckSequence</Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">NACS:TIE</Setting>
    <Setting Target="Host" Name="Framing">None</Setting>
    <Setting Target="Host" Name="AckMode">Byte</Setting>
    <Setting Target="Host" Name="UseAckCommitCodes">1</Setting>
    <Setting Target="Host" Name="IgnoreInboundAck">0</Setting>
    <Setting Target="Host" Name="AddNackERR">0</Setting>
    <Setting Target="Host" Name="BatchHandling">Batch</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">HL7UKvA.2_LE2.2b1022</Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="Charset">UTF-8</Setting>
    <Setting Target="Adapter" Name="ForceCharset">1</Setting>
    <Setting Target="Adapter" Name="JobPerConnection">1</Setting>
    <Setting Target="Adapter" Name="AllowedIPAddresses"></Setting>
    <Setting Target="Adapter" Name="QSize">100</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
    <Setting Target="Adapter" Name="Port">8447</Setting>
    <Setting Target="Adapter" Name="StayConnected">-1</Setting>
    <Setting Target="Adapter" Name="ReadTimeout">5</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
  </Item>
  <Item Name="File Service" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="For testing purposes" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AckTargetConfigNames"></Setting>
    <Setting Target="Host" Name="Framing">Flexible</Setting>
    <Setting Target="Host" Name="TargetConfigNames">MainMessageRouter</Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">ISC:EnsembleHL7</Setting>
    <Setting Target="Host" Name="AckMode">Never</Setting>
    <Setting Target="Host" Name="UseAckCommitCodes">1</Setting>
    <Setting Target="Host" Name="IgnoreInboundAck">1</Setting>
    <Setting Target="Host" Name="BatchHandling">Batch</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">Medway24</Setting>
    <Setting Target="Host" Name="DefCharEncoding">!@UTF8</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\tie\in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Adapter" Name="WorkPath"></Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="FileAccessTimeout">10</Setting>
    <Setting Target="Adapter" Name="AppendTimestamp">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
  </Item>
  <Item Name="DuplicateMessageOperation" Category="BaseTie" ClassName="EnsLib.Workflow.Operation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AutoCreateRole">1</Setting>
    <Setting Target="Host" Name="AlertRetryGracePeriod">0</Setting>
    <Setting Target="Host" Name="RetryInterval">5</Setting>
    <Setting Target="Host" Name="FailureTimeout">15</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
  </Item>
  <Item Name="OutOfSequenceOperation" Category="BaseTie" ClassName="EnsLib.Workflow.Operation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AutoCreateRole">1</Setting>
    <Setting Target="Host" Name="AlertRetryGracePeriod">0</Setting>
    <Setting Target="Host" Name="RetryInterval">5</Setting>
    <Setting Target="Host" Name="FailureTimeout">15</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
  </Item>
  <Item Name="Output To CSCA" Category="BaseTie" ClassName="TIE.HL7.Operation.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="ACK/NACK or HL7 to CSCA" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="ReplyCodeActions">I?=C</Setting>
    <Setting Target="Host" Name="NoFailWhileDisconnected">0</Setting>
    <Setting Target="Host" Name="Separators"><![CDATA[|^~\&]]></Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertRetryGracePeriod">0</Setting>
    <Setting Target="Host" Name="RetryInterval">60</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Host" Name="Framing">MLLP</Setting>
    <Setting Target="Adapter" Name="HTTPServer">127.0.0.1</Setting>
    <Setting Target="Adapter" Name="HTTPPort">8080</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Adapter" Name="ProxyServer"></Setting>
    <Setting Target="Adapter" Name="ProxyPort"></Setting>
    <Setting Target="Adapter" Name="ProxyHTTPS">0</Setting>
    <Setting Target="Adapter" Name="URL">/esiehandler/ESIEServlet</Setting>
    <Setting Target="Adapter" Name="Credentials">None</Setting>
    <Setting Target="Adapter" Name="UseCookies">0</Setting>
    <Setting Target="Adapter" Name="ResponseTimeout">30</Setting>
  </Item>
  <Item Name="CreateSequence" Category="BaseTie" ClassName="EnsLib.HL7.SequenceManager" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="Check sequence numbers and Message Control IDs - MSH:13 and MSH:10 for dups, gaps, lates" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="EnableDuplicatedMessageCheck">1</Setting>
    <Setting Target="Host" Name="PerformSequenceNumberCheckOn">None</Setting>
    <Setting Target="Host" Name="PerformOutputTransformationOn">Receiver</Setting>
    <Setting Target="Host" Name="OutputTargetConfigNames"></Setting>
    <Setting Target="Host" Name="MessageWaitTimeout">60</Setting>
    <Setting Target="Host" Name="PassThroughMessageTypes">QBP_Q21,QBP_Q22,RSP_K21,RSP_K22,ACK</Setting>
    <Setting Target="Host" Name="OutOfSequenceMessageTarget"></Setting>
    <Setting Target="Host" Name="DuplicatedMessageTarget">DuplicateMessageOperation</Setting>
    <Setting Target="Host" Name="OutputFacilityApplication"></Setting>
    <Setting Target="Host" Name="MessageResendableTimeWindow">300</Setting>
    <Setting Target="Host" Name="LargeGapSize">100</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
  </Item>
  <Item Name="File Operation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="For testing purposes" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="Filename">output.txt</Setting>
    <Setting Target="Host" Name="AutoBatchParentSegs">0</Setting>
    <Setting Target="Host" Name="Separators"><![CDATA[|^~\&\r\n]]></Setting>
    <Setting Target="Host" Name="SearchTableClass"></Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertRetryGracePeriod">0</Setting>
    <Setting Target="Host" Name="RetryInterval">5</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Host" Name="Framing">AsciiLF</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\tie\out</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="OpenTimeout">5</Setting>
  </Item>
  <Item Name="Watcher Service" Category="BaseTie" ClassName="TIE.Watcher" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="WatchErrors">1</Setting>
    <Setting Target="Host" Name="WatchWarnings">1</Setting>
    <Setting Target="Host" Name="WatchStart">1</Setting>
    <Setting Target="Host" Name="WatchStop">1</Setting>
    <Setting Target="Host" Name="WatchQueueThreshold">200</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
  </Item>
  <Item Name="Configuration Reader" Category="BaseTie" ClassName="TIE.FileConfigReader" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="Adds or edits components to the production" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\csc\in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Adapter" Name="WorkPath"></Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="FileAccessTimeout">10</Setting>
    <Setting Target="Adapter" Name="AppendTimestamp">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
  </Item>
  <Item Name="TIE Metrics" Category="BaseTie" ClassName="TIE.Metrics" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">60</Setting>
  </Item>
  <Item Name="MainAckMessageRouter" Category="BaseTie" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="Input ACK Message Router" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">NACS:TIE:HL7UKvA.2_LE2.2b1022</Setting>
    <Setting Target="Host" Name="AckType">Commit</Setting>
    <Setting Target="Host" Name="NackCode">Error</Setting>
    <Setting Target="Host" Name="AddNackERR">0</Setting>
    <Setting Target="Host" Name="Validation">dm-z</Setting>
    <Setting Target="Host" Name="BusinessRuleName">TIE.MainAckMessageRouterRules</Setting>
    <Setting Target="Host" Name="AlertOnBadMessage">0</Setting>
    <Setting Target="Host" Name="BadMessageHandler"></Setting>
    <Setting Target="Host" Name="ResponseFrom"></Setting>
    <Setting Target="Host" Name="ResponseTargetConfigNames"></Setting>
    <Setting Target="Host" Name="ResponseTimeout">-1</Setting>
    <Setting Target="Host" Name="ForceSyncSend">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
  </Item>
  <Item Name="EDIS File Service" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="For testing purposes" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AckTargetConfigNames"></Setting>
    <Setting Target="Host" Name="Framing">Flexible</Setting>
    <Setting Target="Host" Name="TargetConfigNames">EDISRouter</Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">ISC:EnsembleHL7</Setting>
    <Setting Target="Host" Name="AckMode">Never</Setting>
    <Setting Target="Host" Name="UseAckCommitCodes">1</Setting>
    <Setting Target="Host" Name="IgnoreInboundAck">1</Setting>
    <Setting Target="Host" Name="BatchHandling">Batch</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">EDIS24</Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\EDIS\in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Adapter" Name="WorkPath"></Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="FileAccessTimeout">10</Setting>
    <Setting Target="Adapter" Name="AppendTimestamp">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
  </Item>
  <Item Name="TotalCARE File Service" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="For testing purposes" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="AckTargetConfigNames"></Setting>
    <Setting Target="Host" Name="Framing">Flexible</Setting>
    <Setting Target="Host" Name="TargetConfigNames">TotalCARERouter</Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">ISC:EnsembleHL7</Setting>
    <Setting Target="Host" Name="AckMode">Never</Setting>
    <Setting Target="Host" Name="UseAckCommitCodes">1</Setting>
    <Setting Target="Host" Name="IgnoreInboundAck">1</Setting>
    <Setting Target="Host" Name="BatchHandling">Batch</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">TotalCARE24</Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertGracePeriod">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\TotalCARE\in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*</Setting>
    <Setting Target="Adapter" Name="ArchivePath"></Setting>
    <Setting Target="Adapter" Name="WorkPath"></Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="FileAccessTimeout">10</Setting>
    <Setting Target="Adapter" Name="AppendTimestamp">0</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
  </Item>
  <Item Name="EDIS File Operation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="For testing purposes" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="Filename">output.txt</Setting>
    <Setting Target="Host" Name="AutoBatchParentSegs">0</Setting>
    <Setting Target="Host" Name="Separators"><![CDATA[|^~\&\r\n]]></Setting>
    <Setting Target="Host" Name="SearchTableClass"></Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertRetryGracePeriod">0</Setting>
    <Setting Target="Host" Name="RetryInterval">5</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Host" Name="Framing">None</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\tie\out</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="OpenTimeout">5</Setting>
  </Item>
  <Item Name="TotalCARE File Operation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" DisableErrorTraps="false" Comment="For testing purposes" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="Filename">output.txt</Setting>
    <Setting Target="Host" Name="AutoBatchParentSegs">0</Setting>
    <Setting Target="Host" Name="Separators">|^~\#\r\n</Setting>
    <Setting Target="Host" Name="SearchTableClass"></Setting>
    <Setting Target="Host" Name="DefCharEncoding">Latin1</Setting>
    <Setting Target="Host" Name="AlertRetryGracePeriod">0</Setting>
    <Setting Target="Host" Name="RetryInterval">5</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Host" Name="Framing">None</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\tie\out</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Adapter" Name="Charset">Default</Setting>
    <Setting Target="Adapter" Name="OpenTimeout">5</Setting>
  </Item>
  <Item Name="TotalCARERouter" Category="BaseTie" ClassName="TIE.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="false" Foreground="false" DisableErrorTraps="false" Comment="Primary Message Router" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="LocalFacilityApplication">NACS:TIE:TotalCARE24</Setting>
    <Setting Target="Host" Name="AckType">Commit</Setting>
    <Setting Target="Host" Name="NackCode">Error</Setting>
    <Setting Target="Host" Name="AddNackERR">0</Setting>
    <Setting Target="Host" Name="Validation">dm-z</Setting>
    <Setting Target="Host" Name="BusinessRuleName">EDISTotalCARE.TotalCAREMessageRouterRules</Setting>
    <Setting Target="Host" Name="AlertOnBadMessage">0</Setting>
    <Setting Target="Host" Name="BadMessageHandler"></Setting>
    <Setting Target="Host" Name="ResponseFrom"></Setting>
    <Setting Target="Host" Name="ResponseTargetConfigNames">MainAckMessageRouter</Setting>
    <Setting Target="Host" Name="ResponseTimeout">-1</Setting>
    <Setting Target="Host" Name="ForceSyncSend">0</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
  </Item>
  <Item Name="Ens.Alert" Category="" ClassName="TIE.AlertToFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">C:\temp\tie\out\</Setting>
    <Setting Target="Host" Name="Filename">error.txt</Setting>
  </Item>
  <Item Name="EnsLib.File.PassthroughOperation" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="KWASPatientTakeon" Category="KWAS" ClassName="KWAS.Service.KwasTakeon" PoolSize="1" Enabled="true" Foreground="false" Comment="KWAS patient takeon" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Delimiter">\</Setting>
    <Setting Target="Adapter" Name="FilePath">c:\temp\tie\kwas\takeon\</Setting>
    <Setting Target="Adapter" Name="FileSpec">kwastakeon.txt</Setting>
  </Item>
  <Item Name="KWASOutputRequest" Category="KWAS" ClassName="KWAS.Service.KWASOutput" PoolSize="0" Enabled="true" Foreground="false" Comment="adapterless request run 15 every minutes from Task Manager" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="KWASUpdate" Category="KWAS" ClassName="KWAS.Operation.KWASUpdate" PoolSize="1" Enabled="true" Foreground="false" Comment="Update the KWAS.Patient.Admission class" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="KWASFileOutput" Category="KWAS" ClassName="KWAS.Operation.KWASFileOutput" PoolSize="1" Enabled="true" Foreground="false" Comment="Output KWAS format file ready for collection" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="Delimiter">\</Setting>
    <Setting Target="Host" Name="Filename">KWAS</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\temp\tie\kwas\output\</Setting>
  </Item>
  <Item Name="PASTCPInput" Category="" ClassName="EnsLib.HL7.Service.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">CheckSequence</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">Medway25</Setting>
    <Setting Target="Adapter" Name="Port">55022</Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
  </Item>
  <Item Name="TIE.NoOpOperation" Category="" ClassName="TIE.NoOpOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="EmailAlert" Category="KWAS" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="From">TIE</Setting>
    <Setting Target="Adapter" Name="Recipient">sdavies20@nhs.net</Setting>
    <Setting Target="Adapter" Name="SMTPPort">25</Setting>
    <Setting Target="Adapter" Name="SMTPServer">SMTP.CNDRH-TR.trent.nhs.uk</Setting>
  </Item>
  <Item Name="KWASHouseCleaningService" Category="KWAS" ClassName="KWAS.Service.KWASHouseCleaning" PoolSize="0" Enabled="true" Foreground="false" Comment="Clean up inactive KWAS patient records" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="GuardianMessageRouter" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Validation">dm-z</Setting>
    <Setting Target="Host" Name="BusinessRuleName">TIE.Guardian.RoutingRules</Setting>
  </Item>
  <Item Name="GuardianFileOperation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\temp\tie\Guardian\out</Setting>
    <Setting Target="Host" Name="Filename">%f_%Q.txt</Setting>
    <Setting Target="Host" Name="Separators">|^~\#\r\n</Setting>
    <Setting Target="Host" Name="DefCharEncoding">!@UTF8</Setting>
  </Item>
  <Item Name="Guardian File Service" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">Medway24</Setting>
    <Setting Target="Host" Name="SearchTableClass">TIE.HL7.SearchTable</Setting>
    <Setting Target="Host" Name="TargetConfigNames">CheckSequence</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\temp\tie\Guardian\in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Host" Name="DefCharEncoding">!@UTF8</Setting>
  </Item>
  <Item Name="GuardianTCPOperation" Category="" ClassName="EnsLib.HL7.Operation.TCPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="IPAddress">!PERINATAL</Setting>
    <Setting Target="Adapter" Name="Port">8022</Setting>
  </Item>
</Production>
}

Property NoOfDaysToKeepKWASRecords As %Integer;

Parameter SETTINGS = "NoOfDaysToKeepKWASRecords";

}
