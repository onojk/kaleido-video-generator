��          �      l      �  G   �  _   )  1   �  >   �  �   �  �  �     @      T  /   u  3   �  =   �       C   1  (   u  �   �  a   M  (   �  p   �  %   I	  �  o	  �  '  J   �     E  B   b  2   �     �  �  �     �     �      �  "     E   '  !   m  <   �  -   �  �   �  T   �  #   �  &        (  �  H               
                                      	                                             
Make sure that the samba package is installed properly on your system. %1 is an error number, %2 either a pretty string or the numberUnknown error condition: [%1] %2 %1:
Unknown file type, neither directory or file. <qt>Please enter authentication information for <b>%1</b></qt> @info:status smb failed to reach the server (e.g. server offline or network failure). %1 is an ip address or hostname%1: Host unreachable @info:whatsthis<para>There are various options for authenticating on SMB shares.</para><para><placeholder>username</placeholder>: When authenticating within a home network the username on the server is sufficient</para><para><placeholder>username@domain.com</placeholder>: Modern corporate logon names are formed like e-mail addresses</para><para><placeholder>DOMAIN\username</placeholder>: For ancient corporate networks or workgroups you may need to prefix the NetBIOS domain name (pre-Windows 2000)</para><para><placeholder>anonymous</placeholder>: Anonymous logins can be attempted using empty username and password. Depending on server configuration non-empty usernames may be required</para> Bad file descriptor Could not connect to host for %1 Error occurred while trying to access %1<nl/>%2 Error while connecting to server responsible for %1 Mounting of share "%1" from host "%2" by user "%3" failed.
%4 No media in device for %1 Please enter authentication information for:
Server = %1
Share = %2 Share could not be found on given server The given name could not be resolved to a unique server. Make sure your network is setup without any name conflicts between names used by Windows and by UNIX name resolution. Unable to find any workgroups in your local network. This might be caused by an enabled firewall. Unmounting of mountpoint "%1" failed.
%2 host entry when no pretty name is available. %1 likely is an IP addressUnknown Device @ <resource>%1</resource> libsmbclient failed to create context libsmbclient reported an error, but did not specify what the problem is. This might indicate a severe problem with your network - but also might indicate a problem with libsmbclient.
If you want to help us, please provide a tcpdump of the network interface while you try to browse (be aware that it might contain private data, so do not post it if you are unsure about that - you can send it privately to the developers if they ask for it) Project-Id-Version: kdeorg
Report-Msgid-Bugs-To: https://bugs.kde.org
PO-Revision-Date: 2024-04-22 15:58
Last-Translator: 
Language-Team: Chinese Simplified
Language: zh_CN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=1; plural=0;
X-Crowdin-Project: kdeorg
X-Crowdin-Project-ID: 269464
X-Crowdin-Language: zh-CN
X-Crowdin-File: /kf6-stable/messages/kio-extras/kio6_smb.pot
X-Crowdin-File-ID: 52764
 
请确保 Samba 软件包已经正确地安装到了在您的系统上。 未知错误条件：[%1] %2 %1：
未知的文件类型，它既不是目录也不是文件。 <qt>请输入 <b>%1</b> 的身份验证信息</qt> %1：主机无法访问 <para>可通过多种方式对 SMB 共享项目进行身份验证。</para><para><placeholder>用户名</placeholder>：在家庭网络内部进行身份验证时，使用服务器上的用户名即可。</para><para><placeholder>用户名@域名.com</placeholder>：新式企业通常会采用电子邮件地址形式的登录名称</para><para><placeholder>域名\用户名</placeholder>：对于旧式企业内网或工作组而言，您可能需要将 NetBIOS 域名作为用户名的前缀 (Windows 2000 之前的操作系统)</para><para><placeholder>匿名</placeholder>：尝试使用空用户名及空密码进行登录。根据服务器的配置情况，可能依然需要填写用户名</para> 无效的文件描述符 无法连接到主机 %1 尝试访问 %1 时出错<nl/>%2 连接到 %1 的服务器时出错 用户“%3”挂载主机“%2”上的共享项“%1”失败。
%4 %1 的设备中没有存储介质 请输入身份验证信息：
服务器 = %1
共享项 = %2 在指定的服务器上无法找到共享项 指定的名称无法解析为唯一的服务器。请确保网络在 Windows 和 UNIX 名称混合解析的情况下不存在命名冲突。 无法在您的局域网中找到任何工作组。可能是防火墙配置错误。 挂载点“%1”卸载失败。
%2 未知设备 @ <resource>%1</resource> libsmbclient 无法创建环境 libsmbclient 报告了错误，但却并未指出原因。您的网络可能存在严重问题 - 但也有可能是 libsmbclient 自身的问题。
如果您想要帮助我们，请提供您网络接口在浏览网页时的 tcpdump (请注意，其中可能包含个人隐私数据，如果你无法确定，请不要公开提交该信息 - 如果我们的开发人员邀请您提供这一信息，您可以通过私人渠道发给他们) 