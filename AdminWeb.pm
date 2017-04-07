package AdminWeb;
use strict;
use Exporter;

our %DATA;

$DATA{'WIDTH_TABLE_1'}="100%";
$DATA{'WIDTH_TABLE_2'}="75%";
$DATA{'WIDTH_TABLE_3'}="35%";

$DATA{'MAIL_ADRES'}="maxim_7\@mail.ru";
$DATA{'DATE'}="";
$DATA{'VERSION'}="1.02";

$DATA{'TIME_SESS'}="+1h";
$DATA{'TMP_PATH'}="";

sub f_style{
print <<STYLE_COD;
<!--табл стилей начало-->
<STYLE type="text/css">
BODY { margin-top: 0; background-color: LightGrey }
submit{
font-size: 22px;
font-weight: bold;
text-align: center;
color: #008000
}
  
</STYLE>

<!--табл стилей конец-->
STYLE_COD
}

sub f_header{
	my ($t,$d,$k,$r)=@_;
	$r=1 unless(defined($r));
	print "<HTML>\n";
	print "<HEAD>\n";
	print "<TITLE> $t </TITLE>\n";
	print "<META http-equiv=\"content-type\" ";
	print "content=\"text/html; charset=utf-8\" >\n";

	if($r == 1){
		print "<META name \"robots\" content=\"index, follow\" >\n";
	}
	else{
	    print "<META name \"robots\" content=\"noindex, nofollow\" >\n";
	}

	&f_style();

	print "</HEAD>\n";
	print "<BODY> \n\n";
	print "<h2><center>Панель управления учета пользователей.</center> </h2> \n";
	
}
sub f_footer{ 
	print "\n<!-- нижний колонтитул--> \n";
	print "<small align=\"right\"> Версия программы $DATA{'VERSION'} &nbsp;&nbsp; Почта $DATA{'MAIL_ADRES'} </small>\n";
	print "</BODY></HTML>";
}

sub f_menu{ 
	print "<!--панель навигации начало-->\n";
	
    print <<text_tabl;
	<FIELDSET><legend>Выберите режим :</legend>
	<TABLE align="left" border="0" cellpadding="0" cellspacing="0" width="25%" >  
    <TR> 
    <td > 
    <form  metod ="post" > <INPUT type="hidden" name="txt" value="newuser" >
    <INPUT name="button" type="submit" value="Добавить_пользователя " >
    </form>
    
    <form  metod ="post" > <INPUT type="hidden" name="txt" value="readuser" >
    <INPUT name="button" type="submit" value="Список_пользователей" >
    </form>
     
    <form  metod ="post" > <INPUT type="hidden" name="txt" value="newroll" >
    <INPUT name="button" type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Добавить_роль &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" >
    </form>

    <form  metod ="post" > <INPUT type="hidden" name="txt" value="readroll" >
    <INPUT name="button" type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Список_ролей &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" >
    </form>

    </td>
    </TR>
    </TABLE>
    
	<FIELDSET><legend>Текущий запрос:</legend>
text_tabl

 print "\n<!-- панель навигации конец-->\n\n";
}

sub f_table_data_start{
	print "<!--табл дл¤ основного содержани¤ страницы начало-->\n";
	print "<TABLE width=\"". $DATA{'WIDTH_TABLE_1'};
	print "\" align=\"left\" border=\"0\" cellpadding=\"2\" cellspacing=\"0\"> \n";
	print "<TR style=\"background-color:  Silver ; \"> \n\n";
     	
}
sub f_table_data_end{
	print "<!--табл дл¤ основного содержани¤ страницы конец--> \n";
	print "</TR></TABLE> </FIELDSET></FIELDSET>\n\n";
	print "<!--табл разделитель конец -->\n";
}

return 1;
