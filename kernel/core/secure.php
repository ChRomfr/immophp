<?php
/*

                                                                               
                                     _,,                                   ,dW 
                                   ,iSMP                                  JIl; 
                                  sPT1Y'                                 JWS:' 
                                 sIl:l1                                 fWIl?  
                                dIi:Il;                                fW1"    
                               dIi:l:I'                               fWI:     
                              dIli:l:I;                              fWI:      
                            .dIli:I:S:S                     .       fWIl`      
                          ,sWSSIIIiISIIS w,_             .sMW     ,MWIl;       
                     _.,sWWW*"'*" , SWW' MWWMm mu,,._  .iSYISb, ,MM*SI!:       
                 _,s YMMWW'',sd,'MM WMMi "*MW* WWWMWMb MMS WWP`,MW' S1!`       
            _,os,'MMi YW' m,'WW; WWb`SWM Im,,  SIS ISW SISIP*  WSi  II!.       
         .osSMWMW,'WSi ',MMP SSb WSW ISII`SYYi III !Il lIi,ui:,*1:li:l1!       
      ,sSMMWWWSSSS,'SWbdWW*  *YSbiSS:'IlI 7llI il1: l! 'l:+'+l; `''+1i:1i      
   ,sYSMWMWY**"""'` 'WWSSIIiu,'**Y11';IIIb ?!li ?l:i,         `      `'l!:     
  sPITMWMW'`.M.wdWWb,'YIi `YT" ,u!1",ISIWWm,'+?+ `'+Ili                `'l:,   
  YIi1lTYfPSkyLinedI!i`I!" .,:!1"',iSWWMMMMMmm,                                
    "T1l1lI**"'`.2006? ',o?*'``  ```""**YSWMMMWMm,                             
         "*:iil1I!I!"` '                 ``"*YMMWWM,                           
               ii!                             '*YMWM,                         
               I'                                  "YM                         
                                                                               

*/
// ANTI INJECTION SQL (UNION) et XSS/CSS
$query_string = strtolower(rawurldecode($_SERVER['QUERY_STRING']));
$bad_string = array("%20union%20", "/*", "*/union/*", "+union+", "load_file", "outfile", "document.cookie", "onmouse", "<script", "<iframe", "<applet", "<meta", "<style", "<form", "<img", "<body", "<link");
foreach ($bad_string as $string_value)
{
    if (strpos($query_string, $string_value)) die("<br /><br /><br /><div style=\"text-align: center;\"><big>What are you trying to do ?</big></div>");
}
unset($query_string, $bad_string, $string_value);

$get_id = array("news_id", "cat_id", "cat", "forum_id", "thread_id", "dl_id", "link_id", "cid", "secid", "artid", "poll_id", "sid", "vid", "im_id", "tid", "game", "war_id", "server_id", "mid", "p", "m", "y", "mo", "ye", "oday", "omonth", "oyear");
foreach ($get_id as $int_id)
{
    if (isset($_GET[$int_id]) && $_GET[$int_id] != "" && !is_numeric($_GET[$int_id])) die("<br /><br /><br /><div style=\"text-align: center;\"><big>Error : ID must be a number !</big></div>");
}
unset($get_id, $int_id);


// FONCTION POUR EMPECHER L'ENVOIE DE FORMULAIRE EXTERNE
if ($_SERVER["REQUEST_METHOD"] == "POST")
{
    if ($_SERVER['HTTP_REFERER'] != "")
    {
  if (!stristr($_SERVER['HTTP_REFERER'],$_SERVER['HTTP_HOST'])) die($_SERVER['HTTP_HOST']. ' <br/> ' . $_SERVER['HTTP_REFERER']. "<br /><br /><br /><div style=\"text-align: center;\"><big>Error : you can't submit request from another server !</big></div>");
    }
    else
    {
  die("<br /><br /><br /><div style=\"text-align: center;\"><big>Error : Referer not found ! Check your browser or firewall's settings.</big></div>");
    }
}