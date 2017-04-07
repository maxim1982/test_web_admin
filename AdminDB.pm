package AdminDB;

use DBI;
use strict;
use Encode qw(encode decode);

our %DBASE;

$DBASE{'DRIVER'}="SQLite";
$DBASE{'DATABASE'}="D:/work/Project/admin/users.db";
$DBASE{'LOGIN'}="";
$DBASE{'PASSW'}="";
$DBASE{'DSN'}="DBI:$DBASE{'DRIVER'}:dbname=$DBASE{'DATABASE'}";

our $dbh ;
our $stmt ;
our $sth ;
our $rv;

sub conn(){
$dbh = DBI->connect($DBASE{'DSN'}, $DBASE{'LOGIN'}, $DBASE{'PASSW'}, { RaiseError => 1 }) 
                      or die $DBI::errstr;					  
#print "<p>Operation done success !</p>";
}

sub read_user(){

   $stmt = qq(SELECT user, password, roll  from user ;);
   $sth = $dbh->prepare( $stmt );
   $rv = $sth->execute() or die $DBI::errstr;

   if($rv < 0){
      print $DBI::errstr;
   }
   
   my @mass_param =split(/ from /,$stmt);
   $mass_param[0] =~ s/select//g;
   $mass_param[0] =~ s/SELECT//g;
   
   $mass_param[0] =~ s/,/<\/td><td class =\"head\">/g;
   
   my $col = 'Honeydew';
   
   print "<td> N </td><td> $mass_param[0] </td>";
   print "<td> Действия: </td></tr> \n <tr style=\"background-color: $col;\">";
   my $i=1;
   
   while(my @row = $sth->fetchrow_array()) {
	  print "<td >$i</td>"; # 
      for (my $r =0 ; $r <scalar(@row); $r++){
          print "<td > $row[$r] </td>";
	  }

	  print "<td><form  metod =\"post\" > <INPUT type=\"hidden\" name=\"iduser\" value=\"$row[0]\" >\n <INPUT name=\"button\" type=\"submit\" value=\"Изменить\" >\n";
	  print "<INPUT name=\"button\" type=\"submit\" value=\"Удалить\" > </form></td>\n";
	  
	  $i++;
	  if ($col eq 'Honeydew' ){ $col = 'Lavender';}
	  else {$col = 'Honeydew';}
	  
	  print "</tr><tr style=\"background-color: $col;\" >\n";
   }

   $sth->finish;
}

sub add_user(){
my ($mode_button,$login,$pass,$roll,$name_sub) ='';
   ($mode_button,$login,$pass,$roll,$name_sub) = @_;
    
print <<text_tabl1;
    <td><b>Введите пользователя :</b></td>
    </TR>	
	<TR style="background-color: Lavender;">	
    <form  metod ="post" >	
	<td> Логин </td>
text_tabl1
	
print   " <td> <INPUT type=\"text\" name=\"login\" value=\"$login\" > </td>";

print <<text_tabl2;
    </TR>	
	<TR style="background-color: Honeydew;">
    <td> Пароль </td>
text_tabl2
	
print "<td> <INPUT type=\"password\" name=\"pwd\" value=\"$pass\" ></td>";

print <<text_tabl3;
    </TR>
	<TR style="background-color: Lavender;">
	<td> Роль в системе	</td>
text_tabl3
	
print "<td> <INPUT type=\"text\" name=\"roll\" value =\"$roll\" > </td>";

print "</TR><TR><td> <INPUT name=\"butaddusr\" type=\"submit\" value=\"$name_sub\" >
       <INPUT type=\"hidden\" name=\"$mode_button\" > </td>  </form>";
  
}

sub add_roll(){

print <<text_tabl;
    <td><b>Введите роль :</b></td>
    </TR>	
	<TR  style="background-color:Lavender;"> 	
    
	<form id="add_rol" metod ="post" >	
	<td> Роль </td>
	<td> <INPUT type="text" name="nameroll" > </td>
	</TR>	
	<TR style="background-color:  Honeydew ;">
    <td> Код </td>
	<td><INPUT type="text" name="coderoll"  ></td>
    </TR>
	<TR>
	<td> <INPUT name="butaddroll" type="submit" value="Добавить_роль" > 
         <INPUT type="hidden" name="addroll" >
	</td>
         
	</form>
text_tabl
   
}

sub executeDB(){
   my $oper = shift();
   
   $stmt = qq($oper);
   $sth = $dbh->prepare( $stmt );
   $rv = $sth->execute() or die $DBI::errstr;

   if($rv < 0){
      print $DBI::errstr;
   }
   my @row = $sth->fetchrow_array() ;
	   
   $sth->finish;
   return @row;
}

sub discon(){
 #$dbh->disconnect();
}
return 1;