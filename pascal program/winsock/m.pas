program server1;
    
    uses windows,winsock;
    
    const myport=1414;//�w�w�q�f

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

    strse : string;
    ip : {string}pchar;
    ipp : array[1..255] of char;

    h : integer;

    begin
    ver:=$0101;
    write('WSAStartup = ');
    try
    wsstatus:=WSAStartup(ver,myWSAData);
    //��l��winsock;�bwindows�U�O�������L�{
    writeln(wsstatus);//winsock���A,0�N���\
    if wsstatus=0 then
    begin
    write('********************************************************************************');
    //�H�U���winsock���A
    Write('Winsock Version found: ');
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
    
    write('socket = ');
    s:=socket(PF_INET,SOCK_STREAM,0);
    //�Ĥ@�B,�إߦ��A����socket,0��ܦ��\
    writeln(s);
    if s<0 then exit;


    write('Input your peer''s port : ');
    readln(h);
    write('Input your peer''s I.P : ');
    readln(strse);
    ipp := strse;



    write('connect = ');
    server.sin_family := AF_INET;
    server.sin_port := htons(h);
    server.sin_addr.s_addr := inet_addr(@ipp);
    ns := connect(s,server,sizeof(server));

    writeln(ns);
    if ns <> 0 then begin writeln('Error : ',WSAGetLastError());readln;exit;end;

    writeln;
    pktlen:=1;
    begin
         repeat
         if pktlen>0 then
         begin
         write('sent->');
         readln(str);
         buf := '';
         buf := str ;
         writeln;
         i := send(s,buf,strlen(buf),0);
         if i < 0 then
         writeln(WSAGetLastError());
         end;
         buf := '';
         pktlen:= recv(s,buf,sizeof(buf),0);//����?�u
         sleep(1);
         writeln('get->',buf);
         until pktlen<1;//�`?�����????��
    end;













    finally
    writeln;
    writeln('********************************************************************************');
    writeln('Press to exit winsocket');
    readln(str);
    wsstatus:=WSACleanup();//�h�Xwinsocket;
    write('WSACleanup = ');
    writeln(wsstatus);
    end;
    writeln;
    writeln('Press to exit');
    {readln(str);}
    end.

