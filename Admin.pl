#!C:/Perl2/bin/perl
no warnings 'layer';
use CGI qw( :standard); 
use CGI::Carp qw(fatalsToBrowser);

require AdminDB;
require AdminWeb;

print "Content-type: text/html\n\n"; 

&AdminWeb::f_header('Панель управления учета пользователей.',$d,$k,$r);
&AdminWeb::f_menu();
&AdminWeb::f_table_data_start();

if(defined(param("txt"))){
	
	&AdminDB::conn();
	
    if ( param("txt") eq 'readuser') { 
       &AdminDB::read_user();
	}
	
    elsif(param("txt") eq 'newroll'){
	     &AdminDB::add_roll();
	}
    
	elsif(param("txt") eq 'newuser'){
	       &AdminDB::add_user("addusr","","","","Добавить");
	}
	elsif ( param("txt") eq 'readroll') { 
           #&AdminDB::read_user();
	}   
	&AdminDB::discon();  
}

	if(defined(param("iduser"))){
	   
	   if (param("button") eq 'Удалить') {
	       print 'Команда  '.param("button").' для записи '. param("iduser") .' выполнена.' ;
		   	   
	       &AdminDB::conn();
	       my $strsql = "delete from user where user = '".param("iduser")."' ;";
	       #print $strsql;
	       &AdminDB::executeDB($strsql) ;
	       &AdminDB::discon();
	   }
	   if (param("button") eq 'Изменить') {
	       #print 'Команда  '.param("button").' для записи '. param("iduser") .' выполнена.' ;
		   
		   
	       &AdminDB::conn();
	       my $strsql = "select * from user where user = '".param("iduser")."' ;"; #print $strsql;
		   my @res = &AdminDB::executeDB($strsql) ;
	       &AdminDB::discon();
		   
		   &AdminDB::add_user("editusr",$res[0],$res[1],$res[2],"Сохранить");
	   }
	}
    
    if(defined(param("addusr"))){
	   
	   &AdminDB::conn();
	   my $strsql = "insert into user (user, password, roll) values( '".param("login")."','".param("pwd")."','".param("roll")."');";
	   #print $strsql;
	   &AdminDB::executeDB($strsql) ;
	   &AdminDB::discon();
	} 
    
    if(defined(param("editusr"))){
	   &AdminDB::conn();
	   
	   my $strsql = "update user set password= '".param("pwd")."', roll = '". param("roll")."' where user = '".param("login")."' ;";
	   
	   &AdminDB::executeDB($strsql) ;
	   &AdminDB::discon();
	   
	}
	
    if(defined(param("addroll"))){
	   &AdminDB::conn();
	   
	   my $strsql = "insert into roles (role, code_role) values( '".param("nameroll")."','".param("coderoll")."');";
	   print $strsql;
	   
	   &AdminDB::executeDB($strsql) ;
	   &AdminDB::discon();
	   
	}
	
	

&AdminWeb::f_table_data_end();	
&AdminWeb::f_footer();
