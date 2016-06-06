program server1;
    
    uses windows,winsock;
    
    const myport=1414;

    var str:string;
    s,ns:TSocket;//type:u_int|integer;
    ver:word;
    rece:TWSAData;//type:WSAData;
    wsstatus:integer;//winsocket_status;
    i,pktlen:integer;
    szd:array[0..WSADESCRIPTION_LEN] of Char;
    szs:array[0..WSASYS_STATUS_LEN] of Char;
    server:sockaddr_in;//tpye:sockaddr_in
    client:PSockAddr;//type:^sockaddr_in
    namelen:PInteger;//type:^Integer;
    buf:array[0..1023] of char;
    wsaast : integer;
    unkn :longint;
    stat : integer;
    con : integer;
    myWSAData : WSADATA;
    qq : array[0..255] of char;
    thn : phostent ;
    Remote_addr : sockaddr_in;
    strse : pchar;
    h : integer;

    begin
    ver:=$0101;
    write('WSAStartup = ');
    try
    wsstatus:=WSAStartup(ver,myWSAData);
    //初始化winsock;在windows下是必須的過程
    writeln(wsstatus);//winsock狀態,0代表成功
    if wsstatus=0 then
    begin
    write('********************************************************************************');
    //以下顯示winsock狀態
    Write('Winsock Version found = ');
    Writeln(lobyte(myWSAData.wVersion),'.',lobyte(myWSAData.wHighVersion));
    write('iMaxSockets = ');
    writeln(myWSAData.iMaxSockets);
    write('iMaxUdpDg = ');
    writeln(myWSAData.iMaxUdpDg);
    write('szDescription = ');
    writeln(myWSAData.szDescription);
    write('szSystemStatus = ');
    writeln(myWSAData.szSystemStatus);
    write('********************************************************************************');
    end;
    begin
    gethostname(@qq,255);
    writeln('Local Hostname = ',qq);
    thn := gethostbyname(@qq);
    thn^.h_addr := thn^.h_addr_list;
    Remote_addr.sin_addr.S_un_b.s_b1 := thn^.h_addr^[0];
    Remote_addr.sin_addr.S_un_b.s_b2 := thn^.h_addr^[1];
    Remote_addr.sin_addr.S_un_b.s_b3 := thn^.h_addr^[2];
    Remote_addr.sin_addr.S_un_b.s_b4 := thn^.h_addr^[3];
    writeln('Local I.P = ',inet_ntoa(Remote_addr.sin_addr));
    randomize;
    h := random(5000)+5000;
    writeln('your port = ',h);
    write('********************************************************************************');
    end;
    write('socket = ');
    s:=socket(AF_INET,SOCK_STREAM,0);
    //第一步,建立服?器的socket,0表示成功
    writeln(s);
    if s<0 then exit;
    
    write('bind = ');
    server.sin_family := AF_INET;
    server.sin_port := htons(h);
    server.sin_addr.s_addr := INADDR_ANY;
    wsstatus:=bind(s,server,sizeof(server));
    //第二步,?定,0表示成功
    writeln(wsstatus);
    if wsstatus<>0 then exit;
    
    write('listen = ');
    wsstatus:=listen(s,5);
    //第三步,?听
    writeln(wsstatus);
    if wsstatus<>0 then exit;
    


    write('accept = ');
    new(client);
    new(namelen);
    namelen^:=sizeof(client^);
    ns:=accept(s,client,namelen);


    //第四步,等待接收
    //注:bind???的是sockaddr_in?构的?据,accept?是??指?!!!
    if ns=-1 then //以下可以做成多?程?程
         begin
         writeln(-1);
         exit;
         end
         else
         begin
         writeln(ns);
         pktlen:=0;
         writeln('recv');
         writeln();
         repeat
         buf := '';
         pktlen:= recv(ns,buf,sizeof(buf),0);//接收?据
         sleep(1);
         writeln('get->',buf);
         if pktlen>0 then
         begin
         write('sent->');
         readln(str);
         buf := '';
         buf := str ;
         writeln;
         i := send(ns,buf,strlen(buf),0);
         end;
         until pktlen<1;//循?直到客????接
         end;
    finally
    writeln;
    writeln('********************************************************************************');
    writeln('Press to exit winsocket');
    readln(str);
    wsstatus:=WSACleanup();//退出winsocket;
    write('WSACleanup = ');
    writeln(wsstatus);
    end;
    writeln;
    writeln('Press to exit');
    {readln(str); }
    end.
