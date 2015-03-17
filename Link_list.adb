with Ada.Text_IO, Ada.Strings.Unbounded.Text_IO;

use Ada.Text_IO, Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;
with Ada.Characters.Handling;
use Ada.Characters.Handling;
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;



procedure assignment2 is


us : Unbounded_String;
type final is array(1..500) of Unbounded_String;
a: final;

b:Integer;
action: Unbounded_String;
c:Boolean:=true;
input_bool:Boolean:=true;
length1:Integer;

type temp2 is array(1..3) of Unbounded_String;
temp1:temp2;
temp3:temp2;
cnt:Integer;


type cmndarray is array(1..2) of Unbounded_String;




function Is_Numeric (Item :Unbounded_String) return Boolean is
      Dummy : Integer;
   begin
      Dummy := Integer'Value (Ada.Strings.Unbounded.To_String(Item));
      return True;
   exception
      when others =>
         return False;
   end Is_Numeric;

function Check_AlphaNumeric(input_String:Unbounded_String) return Boolean is
Alphanumeric_or_not:Boolean;
   begin

      Alphanumeric_or_not:=TRUE;
      for Index_Character in 1..Length(input_String) loop
                  Alphanumeric_or_not:=Is_Alphanumeric(Character'val(Character'pos(element(input_String,Index_Character))));
        exit when Alphanumeric_or_not = False;
      end loop;
     return True;

end Check_AlphaNumeric;

function count_semicolon(Source_String1:Unbounded_String) return INTEGER is
semi_count:Integer:=0;
begin
for index in 1..length(Source_String1) loop

if (slice(Source_String1,index,index)=";") then
semi_count:=semi_count+1;
end if;

end loop;
return semi_count;
end count_semicolon;


function split_string(Source_String1:Unbounded_String) return temp2 is
first:Integer;
last:Integer;
semi_count:Integer:=0;
begin
cnt:=1;
first:=0;
last:=0;
for index in 1..length(Source_String1) loop

if (slice(Source_String1,index,index)=";") then
semi_count:=semi_count+1;
if(first=0)then first:=index;
else last:=index;
end if;

end if;

end loop;
if (first/=0 and last/=0)then
temp3(1):=Ada.Strings.Unbounded.To_Unbounded_string(slice(Source_String1,1,first-1));
temp3(2):=Ada.Strings.Unbounded.To_Unbounded_String(slice(Source_String1,first+1,last-1));
temp3(3):=Ada.Strings.Unbounded.To_Unbounded_String(slice(Source_String1,last+1,length(Source_String1)));
end if;
return temp3;
end split_string;




function split_command(Source_String1:Unbounded_String) return cmndarray is

first:Integer;
last:Integer;
cmdarray:cmndarray;
begin

cnt:=1;
first:=0;
last:=0;
for index in 1..length(Source_String1) loop

if (slice(Source_String1,index,index)=" ") then

if (first=0)then first:=index;last:=index;
else last:=index;
end if;

end if;

end loop;

if(first/=0 and last/=0)then
cmdarray(1):=Ada.Strings.Unbounded.To_Unbounded_string(slice(Source_String1,1,first-1));
cmdarray(2):=Ada.Strings.Unbounded.To_Unbounded_String(slice(Source_String1,last+1,length(Source_String1)));
end if;

return cmdarray;
end split_command;


function count_links(curr:Integer;arr:final) return Integer is
cnt:Integer:=1;
check:Boolean:=true;
strarray:temp2;
next:Integer;
current:Integer;
curr1:Integer;
begin
curr1:=curr;
while check loop

for index in 1..arr'length loop

strarray:= split_string(arr(index));
current:=Integer'value(Ada.Strings.Unbounded.To_String(strarray(1)));


if(curr1=current)then 
if(strarray(3)/="") then
cnt:=cnt+1;
--Put_Line(strarray(3));
next:=Integer'value(Ada.Strings.Unbounded.To_String(strarray(3)));
curr1:=next;
goto Continue;

else check:=false;
goto Continue;
end if;
end if;
end loop;
<<Continue>>
null;
end loop;




return cnt;
end count_links;







function count_link(curr:Integer;arr:final) return Integer is
cnt:Integer:=0;
check:Boolean:=true;
strarray:temp2;
next:Integer;
current:Integer;
curr1:Integer;
begin
curr1:=curr;
while check loop

for index in 1..arr'length loop

strarray:= split_string(arr(index));

if(strarray(3)/="")then
current:=Integer'value(Ada.Strings.Unbounded.To_String(strarray(3)));

if(curr1=current)then 
cnt:=cnt+1;
--Put_Line(strarray(3));
next:=Integer'value(Ada.Strings.Unbounded.To_String(strarray(1)));
curr1:=next;
goto Continue;
else check:=false;
goto Continue;
end if;

end if;
end loop;
<<Continue>>
null;
end loop;




return cnt;
end count_link;



function count_sum(curr:Integer;arr:final) return Unbounded_String is
sum:Integer:=0;
check:Boolean:=true;
strarray:temp2;
next:Integer;
current:Integer;
curr1:Integer;
finalstr:Unbounded_String;
isdigit:Boolean:=true;
begin
curr1:=curr;
for t in 1..arr'length loop
strarray:= split_string(arr(t));
isdigit:=Is_Numeric(strarray(2));
if isdigit=false then
goto Continue1;
end if;
end loop;
<<Continue1>>
null;
while check loop

for index in 1..arr'length loop

strarray:= split_string(arr(index));
current:=Integer'value(Ada.Strings.Unbounded.To_String(strarray(1)));


if(curr1=current)then 
if isdigit then
sum:=sum+Integer'value(Ada.Strings.Unbounded.To_String(strarray(2)));
else
finalstr:=finalstr&strarray(2);
end if;
if(strarray(3)/="") then
--Put_Line(strarray(3));
next:=Integer'value(Ada.Strings.Unbounded.To_String(strarray(3)));
curr1:=next;
goto Continue;

else check:=false;
goto Continue;
end if;
end if;
end loop;
<<Continue>>
null;
end loop;
if isdigit then
finalstr:=Ada.Strings.Unbounded.To_Unbounded_String(Integer'image(sum));
end if;

return finalstr;
end count_sum;




input_cnt:Integer;

input_cmd:cmndarray;






--main function
begin
input_cnt:=1;
while input_bool loop

a(input_cnt):=Get_Line;
temp1:=split_string(a(input_cnt));
if(temp1(3)="")then
input_bool:=false;
else

if(count_semicolon(a(input_cnt))>=3)then
Put_Line("BAD");
input_bool:=false;
goto exit1;
end if;

if(Is_Numeric(temp1(1)) and Is_Numeric(temp1(3)) and Check_AlphaNumeric(temp1(2)))then 
input_cnt:=input_cnt+1;
else
Put_Line("BAD");
end if;
end if;
end loop;


while c loop

action:=Get_line;

if(slice(action,1,3)="sum" or slice(action,1,3)="SUM")then
input_cmd:=split_command(action);
Put_Line(count_sum(Integer'value(Ada.Strings.Unbounded.To_String(input_cmd(2))),a));


elsif(slice(action,1,4)="quit" or slice(action,1,4)="QUIT")then
--Put_Line("here");
c:=false;
goto exit1;

elsif(slice(action,1,5)="count" or slice(action,1,5)="COUNT")then
--Put_Line(temp1(2));
--b:=Integer'value(Ada.Strings.Unbounded.To_String(temp1(2)));
input_cmd:=split_command(action);
b:=count_links(Integer'value(Ada.Strings.Unbounded.To_String(input_cmd(2))),a);
Put_Line(Integer'image(b));

elsif(slice(action,1,5)="links" or slice(action,1,5)="LINKS")then
input_cmd:=split_command(action);
b:=input_cnt-count_links(Integer'value(Ada.Strings.Unbounded.To_String(input_cmd(2))),a);
Put_Line(Integer'image(b));

elsif(slice(action,1,6)="unused" or slice(action,1,6)="UNUSED" )then
input_cmd:=split_command(action);
b:=count_link(Integer'value(Ada.Strings.Unbounded.To_String(input_cmd(2))),a);
Put_Line(Integer'image(b));

else
Put_Line("ERR");

end if;

end loop;
<<exit1>>
null;
end assignment2;
