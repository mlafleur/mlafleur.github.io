---
title: Workflow Differences in UCMA 3.0
excerpt: ""
tags:
  - Skype
---
The following is a list of activities from Speech Server 2007 and UCMA 3.0. UCMA brings with it a number of new activities (due mostly to UCMA handling both Speech and Instant Messaging) but it also drops a number of activities we've become used to having in Speech Server.
  <table cellspacing="0" cellpadding="0">     <tr>       <td>         <strong>Speech Server 2007</strong>
       </td>        <td>         <strong>UCMA 3.0</strong>
       </td>     </tr>      <tr>       <td>         AnswerCall
       </td>        <td>         AcceptCall
       </td>     </tr>      <tr>       <td>         BlindTransfer
       </td>        <td>         BlindTransfer
       </td>     </tr>      <tr>       <td>         Command
       </td>        <td>         SpeechCommand
       </td>     </tr>      <tr>       <td>         ConsecutiveNoInputsSpeechEvent
       </td>        <td>         ConsecutiveNoInputsSpeechEvent
       </td>     </tr>      <tr>       <td>         ConsecutiveNoRecognitionsSpeechEvent
       </td>        <td>         ConsecutiveNoRecognitionsSpeechEvent
       </td>     </tr>      <tr>       <td>         ConsecutiveSilencesSpeechEvent
       </td>        <td>         ConsecutiveSilencesSpeechEvent
       </td>     </tr>      <tr>       <td>         DeclineCall
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         DetectAnsweringMachine
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         DisconnectCall
       </td>        <td>         DisconnectCall
       </td>     </tr>      <tr>       <td>         FormFillingDialog
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         GetAndConfirm
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         GoTo
       </td>        <td>         GoTo
       </td>     </tr>      <tr>       <td>         HelpCommand
       </td>        <td>         SpeechHelpCommand
       </td>     </tr>      <tr>       <td>         InvokeWorkflow
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         MakeCall
       </td>        <td>         OutboundCall
       </td>     </tr>      <tr>       <td>         Menu
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         NavigableList
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         QuestionAnswer
       </td>        <td>         SpeechQuestionAnswer
       </td>     </tr>      <tr>       <td>         RecordAudio
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         RecordMessage
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         RepeatCommand
       </td>        <td>         SpeechRepeatCommand
       </td>     </tr>      <tr>       <td>         SaltInterpreter
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         SetTaskStatus
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         SpeechSequence
       </td>        <td>         CommunicationsSquence
       </td>     </tr>      <tr>       <td>         Statement
       </td>        <td>         SpeechStatement
       </td>     </tr>      <tr>       <td>         Validator
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         VoiceXmlInterpreter
       </td>        <td>         -
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         CallDisconnectedEvent
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         CallOnHoldEvent
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         CallOnHoldTimeoutEvent
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         CallRetrievedEvent
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         GetPresence
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         InstantMessagingStatement
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         InstantMessagingQuestioNAnswer
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         InstantMessagingCommand
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         InstantMessagingCommand
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         InstantMessagingHelpCommand
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         ConsecutiveNoInputsInstantMessageEvent
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         ConsecutiveSilencesInstantMessagingEvent
       </td>     </tr>      <tr>       <td>         -
       </td>        <td>         ConsecutiveNoRecognitionsInstantMessagingEvent
       </td>     </tr>   </table>  In the coming weeks I'll be covering some workarounds to the missing activities.
<img src="http://gotspeech.net/aggbug.aspx?PostID=11181" width="1" height="1"/>