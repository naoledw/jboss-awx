wsl --list --online
clear
sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
ansible --version
ssh-keygen -t rsa -b 4096
ssh-copy-id domuser@10.1.237.222
ssh-copy-id t24user@10.1.237.222
ssh t24user@10.1.237.222
clear
mkdir -p ~/ansible-jboss-management
cd ~/ansible-jboss-management
mkdir -p inventory group_vars roles
ls -lrt
cd inventory/
ls -lrt
vi hosts
vi ~/.ssh/config
cat ~/.ssh/config
pwd
cd ../
ls -lrt
cd ../
ls -lrt
cd ../
ls -lrt
ls -lrta
cat ~/.ssh/config
vi ~/.ssh/config
cd /mnt/c/Users/YourUser/ansible-jboss-management
cd /mnt/c/Users/naole/ansible-jboss-management
pwd
cd naole/ansible-jboss-management/
vi ansible.cfg
ansible all -m ping
ansible all -m command -a "uptime"
ansible-playbook site.yml --ask-vault-pass
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
sudo apt install dos2unix
pwd
ls -lrt
ansible-playbook site.yml --ask-vault-pass
cd ~/ansible-jboss-management
pwd
vi site.yml
mkdir -p inventory group_vars roles/jboss-management/{tasks,handlers,templates,files,vars}
ls -lrt
cat > inventory/hosts << 'EOF'
[jboss_masters]
dc1 ansible_host=10.1.1.1

[jboss_slaves]
dc2 ansible_host=10.2.2.2

[jboss_domain:children]
jboss_masters
jboss_slaves

[jboss_domain:vars]
ansible_user=your_ssh_user
ansible_ssh_private_key_file=~/.ssh/your_private_key
jboss_home=/opt/jboss-eap
jboss_user=jboss
EOF

ls -lrt
cat > roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss user and group exist
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
  when: ansible_os_family == "RedHat"

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Copy JBoss startup scripts
  template:
    src: "jboss.service.j2"
    dest: "/etc/systemd/system/jboss-domain.service"
    owner: root
    group: root
    mode: '0644'
  notify: reload systemd

- name: Ensure JBoss service is enabled and running
  systemd:
    name: jboss-domain
    state: started
    enabled: yes
    daemon_reload: yes

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']
  notify: restart jboss

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
  notify: restart jboss
EOF

# Create handlers file
cat > roles/jboss-management/handlers/main.yml << 'EOF'
---
- name: restart jboss
  systemd:
    name: jboss-domain
    state: restarted

- name: reload systemd
  systemd:
    daemon_reload: yes
EOF

clear
ls -lrt
cd inventory/
ls -lrt
cd ../
pwd
ls -lrt
cat > roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss user and group exist
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
  when: ansible_os_family == "RedHat"

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Copy JBoss startup scripts
  template:
    src: "jboss.service.j2"
    dest: "/etc/systemd/system/jboss-domain.service"
    owner: root
    group: root
    mode: '0644'
  notify: reload systemd

- name: Ensure JBoss service is enabled and running
  systemd:
    name: jboss-domain
    state: started
    enabled: yes
    daemon_reload: yes

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']
  notify: restart jboss

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
  notify: restart jboss
EOF

ls -lrt
cd roles/
ls -lrt
cd jboss-management/
ls -lrt
cd tasks/
ls -lrt
cat main.yml 
cat > roles/jboss-management/handlers/main.yml << 'EOF'
---
- name: restart jboss
  systemd:
    name: jboss-domain
    state: restarted

- name: reload systemd
  systemd:
    daemon_reload: yes
EOF

clear
pwd
cd ../
cat > roles/jboss-management/handlers/main.yml << 'EOF'
---
- name: restart jboss
  systemd:
    name: jboss-domain
    state: restarted

- name: reload systemd
  systemd:
    daemon_reload: yes
EOF

cd ../
ls -lrt
pwd
ls -lrt
cat > roles/jboss-management/handlers/main.yml << 'EOF'
---
- name: restart jboss
  systemd:
    name: jboss-domain
    state: restarted

- name: reload systemd
  systemd:
    daemon_reload: yes
EOF

cd ..
pwd
cat > roles/jboss-management/handlers/main.yml << 'EOF'
---
- name: restart jboss
  systemd:
    name: jboss-domain
    state: restarted

- name: reload systemd
  systemd:
    daemon_reload: yes
EOF

ls -lrt
cat roles/jboss-management/handlers/main.yml
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
pwd
clear
pwd
cat > site.yml << 'EOF'
---
- name: Configure JBoss EAP Domain
  hosts: jboss_domain
  become: yes
  vars_files:
    - secrets.yml
  roles:
    - jboss-management
EOF

ansible-playbook -i inventory/hosts site.yml --ask-become-pass
pwd
ls -lrt
cd inventory/
ls -lrt
cat hosts 
vi hosts 
pwd
cd ../
ls -lrt
cd ../
ls -lrt
cd ../
ls -lrt
ls -lrta
cd naole/
ls -lrta
cd .ssh/
ls -lrta
pwd
cd ../
cd ansible-jboss-management/
cd inventory/
ls -lrt
vi hosts
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
pwd
cd ../
pwd
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
vi inventory/hosts
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
vi inventory/hosts
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
pwd
cd ~/ansible-jboss-management/roles/jboss-management/templates/
ls -lrt
cat > jboss.service.j2 << 'EOF'
[Unit]
Description=JBoss EAP Domain Mode
After=network.target

[Service]
Type=forking
User={{ t24user }}
Group={{ t24group }}
ExecStart={{ /u01/T24/JBOSS }}/bin/domain-start.sh
ExecStop={{ /u01/T24/JBOSS }}/bin/jboss-cli.sh --connect :shutdown
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

ls -lrt
cat > host-slave.xml.j2 << 'EOF'
<?xml version='1.0' encoding='UTF-8'?>

<host xmlns="urn:jboss:domain:16.0">
    <extensions>
        <extension module="org.jboss.as.jmx"/>
        <extension module="org.wildfly.extension.core-management"/>
        <extension module="org.wildfly.extension.elytron"/>
    </extensions>
    <management>
        <security-realms>
            <security-realm name="ManagementRealm">
                <authentication>
                    <local default-user="$local" skip-group-loading="true"/>
                    <properties path="mgmt-users.properties" relative-to="jboss.domain.config.dir"/>
                </authentication>
                <authorization map-groups-to-roles="false">
                    <properties path="mgmt-groups.properties" relative-to="jboss.domain.config.dir"/>
                </authorization>
            </security-realm>
            <security-realm name="ApplicationRealm">
                <server-identities>
                    <ssl>
                        <keystore path="application.keystore" relative-to="jboss.domain.config.dir" keystore-password="password" alias="server" key-password="password" generate-self-signed-certificate-host="localhost"/>
                    </ssl>
                </server-identities>
                <authentication>
                    <local default-user="$local" allowed-users="*" skip-group-loading="true"/>
                    <properties path="application-users.properties" relative-to="jboss.domain.config.dir"/>
                </authentication>
                <authorization>
                    <properties path="application-roles.properties" relative-to="jboss.domain.config.dir"/>
                </authorization>
            </security-realm>
        </security-realms>
        <audit-log>
            <formatters>
                <json-formatter name="json-formatter"/>
            </formatters>
            <handlers>
                <file-handler name="host-file" formatter="json-formatter" path="audit-log.log" relative-to="jboss.domain.data.dir"/>
                <file-handler name="server-file" formatter="json-formatter" path="audit-log.log" relative-to="jboss.server.data.dir"/>
            </handlers>
            <logger log-boot="true" log-read-only="false" enabled="false">
                <handlers>
                    <handler name="host-file"/>
                </handlers>
            </logger>
            <server-logger log-boot="true" log-read-only="false" enabled="false">
                <handlers>
                    <handler name="server-file"/>
                </handlers>
            </server-logger>
        </audit-log>
        <management-interfaces>
            <http-interface security-realm="ManagementRealm">
                <http-upgrade enabled="true"/>
                <socket interface="management" port="${jboss.management.http.port:9990}"/>
            </http-interface>
        </management-interfaces>
    </management>
    <domain-controller>
        <local/>
    </domain-controller>
    <interfaces>
        <interface name="management">
            <inet-address value="${jboss.bind.address.management:0.0.0.0}"/>
        </interface>
        <interface name="public">
            <inet-address value="${jboss.bind.address:0.0.0.0}"/>
        </interface>
    </interfaces>
    <jvms>
        <jvm name="default">
            <heap size="1G" max-size="4G"/>
            <jvm-options>
                <option value="-server"/>
                <option value="-XX:MetaspaceSize=2G"/>
                <option value="-XX:MaxMetaspaceSize=8G"/>
                <option value="-XX:+UseG1GC"/>
                <option value="-XX:MaxGCPauseMillis=20"/>
                <option value="-verbose:gc"/>
                <option value="-XX:+PrintGCDetails"/>
                <option value="-XX:+PrintGCDateStamps"/>
                <option value="-XX:+UseGCLogFileRotation"/>
                <option value="-XX:NumberOfGCLogFiles=5"/>
                <option value="-XX:GCLogFileSize=3M"/>
                <option value="-XX:-TraceClassUnloading"/>
                <option value="-Xloggc:/u01/T24/JBOSS/domain/servers/Browser-server/log/Browser-server-gc.log"/>
                <option value="--add-exports=java.base/sun.nio.ch=ALL-UNNAMED"/>
            </jvm-options>
        </jvm>
    </jvms>
jboss.service.j2   <servers>
            <server name="Browser-server" group="Browser-server-group" auto-start="true">
              <jvm name="default">
              </jvm>
           </server>
           <server name="Mobile-server" group="Mobile-server-group" auto-start="true">
              <jvm name="default">
              </jvm>
           </server>
    </servers>
    <profile>
        <subsystem xmlns="urn:jboss:domain:core-management:1.0"/>
        <subsystem xmlns="urn:wildfly:elytron:13.0" final-providers="combined-providers" disallowed-providers="OracleUcrypto">
            <providers>
                <aggregate-providers name="combined-providers">
                    <providers name="elytron"/>
                    <providers name="openssl"/>
                </aggregate-providers>
                <provider-loader name="elytron" module="org.wildfly.security.elytron"/>
                <provider-loader name="openssl" module="org.wildfly.openssl"/>
            </providers>
            <audit-logging>
                <file-audit-log name="local-audit" path="audit.log" relative-to="jboss.domain.log.dir" format="JSON"/>
            </audit-logging>
            <security-domains>
                <security-domain name="ManagementDomain" default-realm="ManagementRealm" permission-mapper="default-permission-mapper">
                    <realm name="ManagementRealm" role-decoder="groups-to-roles"/>
                    <realm name="local" role-mapper="super-user-mapper"/>
                </security-domain>
            </security-domains>
            <security-realms>
                <identity-realm name="local" identity="$local"/>
                <properties-realm name="ManagementRealm">
                    <users-properties path="mgmt-users.properties" relative-to="jboss.domain.config.dir" digest-realm-name="ManagementRealm"/>
                    <groups-properties path="mgmt-groups.properties" relative-to="jboss.domain.config.dir"/>
                </properties-realm>
            </security-realms>
            <mappers>
                <simple-permission-mapper name="default-permission-mapper" mapping-mode="first">
                    <permission-mapping>
                        <principal name="anonymous"/>
                        <permission-set name="default-permissions"/>
                    </permission-mapping>
                    <permission-mapping match-all="true">
                        <permission-set name="login-permission"/>
                        <permission-set name="default-permissions"/>
                    </permission-mapping>
                </simple-permission-mapper>
                <constant-realm-mapper name="local" realm-name="local"/>
                <simple-role-decoder name="groups-to-roles" attribute="groups"/>
                <constant-role-mapper name="super-user-mapper">
                    <role name="SuperUser"/>
                </constant-role-mapper>
            </mappers>
            <permission-sets>
                <permission-set name="login-permission">
                    <permission class-name="org.wildfly.security.auth.permission.LoginPermission"/>
                </permission-set>
                <permission-set name="default-permissions"/>
            </permission-sets>
            <http>
                <http-authentication-factory name="management-http-authentication" security-domain="ManagementDomain" http-server-mechanism-factory="global">
                    <mechanism-configuration>
                        <mechanism mechanism-name="BASIC">
                            <mechanism-realm realm-name="Management Realm"/>
                        </mechanism>
                    </mechanism-configuration>
                </http-authentication-factory>
                <provider-http-server-mechanism-factory name="global"/>
            </http>
            <sasl>
                <sasl-authentication-factory name="management-sasl-authentication" sasl-server-factory="configured" security-domain="ManagementDomain">
                    <mechanism-configuration>
                        <mechanism mechanism-name="JBOSS-LOCAL-USER" realm-mapper="local"/>
                        <mechanism mechanism-name="DIGEST-MD5">
                            <mechanism-realm realm-name="ManagementRealm"/>
                        </mechanism>
                    </mechanism-configuration>
                </sasl-authentication-factory>
                <configurable-sasl-server-factory name="configured" sasl-server-factory="elytron">
                    <properties>
                        <property name="wildfly.sasl.local-user.default-user" value="$local"/>
                    </properties>
                </configurable-sasl-server-factory>
                <mechanism-provider-filtering-sasl-server-factory name="elytron" sasl-server-factory="global">
                    <filters>
                        <filter provider-name="WildFlyElytron"/>
                    </filters>
                </mechanism-provider-filtering-sasl-server-factory>
                <provider-sasl-server-factory name="global"/>
            </sasl>
        </subsystem>
        <subsystem xmlns="urn:jboss:domain:jmx:1.3">
            <expose-resolved-model/>
            <expose-expression-model/>
            <remoting-connector/>
        </subsystem>
    </profile>
</host>
EOF

ls -lrt
cat > host-master.xml.j2 << 'EOF'
<?xml version='1.0' encoding='UTF-8'?>

<host xmlns="urn:jboss:domain:16.0">
    <extensions>
        <extension module="org.jboss.as.jmx"/>
        <extension module="org.wildfly.extension.core-management"/>
        <extension module="org.wildfly.extension.elytron"/>
    </extensions>
    <management>
        <security-realms>
            <security-realm name="ManagementRealm">
                <authentication>
                    <local default-user="$local" skip-group-loading="true"/>
                    <properties path="mgmt-users.properties" relative-to="jboss.domain.config.dir"/>
                </authentication>
                <authorization map-groups-to-roles="false">
                    <properties path="mgmt-groups.properties" relative-to="jboss.domain.config.dir"/>
                </authorization>
            </security-realm>
            <security-realm name="ApplicationRealm">
                <server-identities>
                    <ssl>
                        <keystore path="application.keystore" relative-to="jboss.domain.config.dir" keystore-password="password" alias="server" key-password="password" generate-self-signed-certificate-host="localhost"/>
                    </ssl>
                </server-identities>
                <authentication>
                    <local default-user="$local" allowed-users="*" skip-group-loading="true"/>
                    <properties path="application-users.properties" relative-to="jboss.domain.config.dir"/>
                </authentication>
                <authorization>
                    <properties path="application-roles.properties" relative-to="jboss.domain.config.dir"/>
                </authorization>
            </security-realm>
        </security-realms>
        <audit-log>
            <formatters>
                <json-formatter name="json-formatter"/>
            </formatters>
            <handlers>
                <file-handler name="host-file" formatter="json-formatter" path="audit-log.log" relative-to="jboss.domain.data.dir"/>
                <file-handler name="server-file" formatter="json-formatter" path="audit-log.log" relative-to="jboss.server.data.dir"/>
            </handlers>
            <logger log-boot="true" log-read-only="false" enabled="false">
                <handlers>
                    <handler name="host-file"/>
                </handlers>
            </logger>
            <server-logger log-boot="true" log-read-only="false" enabled="false">
                <handlers>
                    <handler name="server-file"/>
                </handlers>
            </server-logger>
        </audit-log>
        <management-interfaces>
            <http-interface security-realm="ManagementRealm">
                <http-upgrade enabled="true"/>
                <socket interface="management" port="${jboss.management.http.port:9990}"/>
            </http-interface>
        </management-interfaces>
    </management>
    <domain-controller>
        <local/>
    </domain-controller>
    <interfaces>
        <interface name="management">
            <inet-address value="${jboss.bind.address.management:0.0.0.0}"/>
        </interface>
        <interface name="public">
            <inet-address value="${jboss.bind.address:0.0.0.0}"/>
        </interface>
    </interfaces>
    <jvms>
        <jvm name="default">
            <heap size="1G" max-size="4G"/>
            <jvm-options>
                <option value="-server"/>
                <option value="-XX:MetaspaceSize=2G"/>
                <option value="-XX:MaxMetaspaceSize=8G"/>
                <option value="-XX:+UseG1GC"/>
                <option value="-XX:MaxGCPauseMillis=20"/>
                <option value="-verbose:gc"/>
                <option value="-XX:+PrintGCDetails"/>
                <option value="-XX:+PrintGCDateStamps"/>
                <option value="-XX:+UseGCLogFileRotation"/>
                <option value="-XX:NumberOfGCLogFiles=5"/>
                <option value="-XX:GCLogFileSize=3M"/>
                <option value="-XX:-TraceClassUnloading"/>
                <option value="-Xloggc:/u01/T24/JBOSS/domain/servers/Browser-server/log/Browser-server-gc.log"/>
                <option value="--add-exports=java.base/sun.nio.ch=ALL-UNNAMED"/>
            </jvm-options>
        </jvm>
    </jvms>
  <servers>
            <server name="Browser-server" group="Browser-server-group" auto-start="true">
              <jvm name="default">
              </jvm>
           </server>
           <server name="Mobile-server" group="Mobile-server-group" auto-start="true">
              <jvm name="default">
              </jvm>
           </server>
    </servers>
    <profile>
        <subsystem xmlns="urn:jboss:domain:core-management:1.0"/>
        <subsystem xmlns="urn:wildfly:elytron:13.0" final-providers="combined-providers" disallowed-providers="OracleUcrypto">
            <providers>
                <aggregate-providers name="combined-providers">
                    <providers name="elytron"/>
                    <providers name="openssl"/>
                </aggregate-providers>
                <provider-loader name="elytron" module="org.wildfly.security.elytron"/>
                <provider-loader name="openssl" module="org.wildfly.openssl"/>
            </providers>
            <audit-logging>
                <file-audit-log name="local-audit" path="audit.log" relative-to="jboss.domain.log.dir" format="JSON"/>
            </audit-logging>
            <security-domains>
                <security-domain name="ManagementDomain" default-realm="ManagementRealm" permission-mapper="default-permission-mapper">
                    <realm name="ManagementRealm" role-decoder="groups-to-roles"/>
                    <realm name="local" role-mapper="super-user-mapper"/>
                </security-domain>
            </security-domains>
            <security-realms>
                <identity-realm name="local" identity="$local"/>
                <properties-realm name="ManagementRealm">
                    <users-properties path="mgmt-users.properties" relative-to="jboss.domain.config.dir" digest-realm-name="ManagementRealm"/>
                    <groups-properties path="mgmt-groups.properties" relative-to="jboss.domain.config.dir"/>
                </properties-realm>
            </security-realms>
            <mappers>
                <simple-permission-mapper name="default-permission-mapper" mapping-mode="first">
                    <permission-mapping>
                        <principal name="anonymous"/>
                        <permission-set name="default-permissions"/>
                    </permission-mapping>
                    <permission-mapping match-all="true">
                        <permission-set name="login-permission"/>
                        <permission-set name="default-permissions"/>
                    </permission-mapping>
                </simple-permission-mapper>
                <constant-realm-mapper name="local" realm-name="local"/>
                <simple-role-decoder name="groups-to-roles" attribute="groups"/>
                <constant-role-mapper name="super-user-mapper">
                    <role name="SuperUser"/>
                </constant-role-mapper>
            </mappers>
            <permission-sets>
                <permission-set name="login-permission">
                    <permission class-name="org.wildfly.security.auth.permission.LoginPermission"/>
                </permission-set>
                <permission-set name="default-permissions"/>
            </permission-sets>
            <http>
                <http-authentication-factory name="management-http-authentication" security-domain="ManagementDomain" http-server-mechanism-factory="global">
                    <mechanism-configuration>
                        <mechanism mechanism-name="BASIC">
                            <mechanism-realm realm-name="Management Realm"/>
                        </mechanism>
                    </mechanism-configuration>
                </http-authentication-factory>
                <provider-http-server-mechanism-factory name="global"/>
            </http>
            <sasl>
                <sasl-authentication-factory name="management-sasl-authentication" sasl-server-factory="configured" security-domain="ManagementDomain">
                    <mechanism-configuration>
                        <mechanism mechanism-name="JBOSS-LOCAL-USER" realm-mapper="local"/>
                        <mechanism mechanism-name="DIGEST-MD5">
                            <mechanism-realm realm-name="ManagementRealm"/>
                        </mechanism>
                    </mechanism-configuration>
                </sasl-authentication-factory>
                <configurable-sasl-server-factory name="configured" sasl-server-factory="elytron">
                    <properties>
                        <property name="wildfly.sasl.local-user.default-user" value="$local"/>
                    </properties>
                </configurable-sasl-server-factory>
                <mechanism-provider-filtering-sasl-server-factory name="elytron" sasl-server-factory="global">
                    <filters>
                        <filter provider-name="WildFlyElytron"/>
                    </filters>
                </mechanism-provider-filtering-sasl-server-factory>
                <provider-sasl-server-factory name="global"/>
            </sasl>
        </subsystem>
        <subsystem xmlns="urn:jboss:domain:jmx:1.3">
            <expose-resolved-model/>
            <expose-expression-model/>
            <remoting-connector/>
        </subsystem>
    </profile>
</host>
EOF

ls -lrt
cat > ~/ansible-jboss-management/secrets.yml << 'EOF'
---
jboss_slave_user: "slave_user"
jboss_slave_secret: "your_slave_password_here"
EOF

cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss.service.j2 << 'EOF'
[Unit]
Description=JBoss EAP Domain Mode
After=network.target

[Service]
Type=forking
User={{ t24user }}
Group={{ t24group }}
ExecStart={{ JBOSS_HOME }}/bin/domain.sh
ExecStop={{ JBOSS_HOME }}/bin/jboss-cli.sh --connect :shutdown
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss.service.j2 << 'EOF'
[Unit]
Description=JBoss EAP Domain Mode
After=network.target

[Service]
Type=forking
User={{ t24user }}
Group={{ t24group }}
ExecStart={{ jboss_home }}/bin/domain.sh
ExecStop={{ jboss_home }}/bin/jboss-cli.sh --connect :shutdown
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

grep -r "{{ /" ~/ansible-jboss-management/roles/jboss-management/templates/
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss.service.j2 << 'EOF'
[Unit]
Description=JBoss EAP Domain Mode
After=network.target

[Service]
Type=forking
User={{ zerihun }}
Group={{  }}
ExecStart={{ jboss_home }}/bin/domain.sh
ExecStop={{ jboss_home }}/bin/jboss-cli.sh --connect :shutdown
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
~/ansible-jboss-management/inventory/hosts
vi ~/ansible-jboss-management/inventory/hosts
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
vi ~/ansible-jboss-management/inventory/hosts
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
sudo vi ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml
clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Copy JBoss startup scripts
  template:
    src: "jboss.service.j2"
    dest: "/etc/systemd/system/jboss-domain.service"
    owner: t24user
    group: t24group
    mode: '0644'
  notify: reload systemd

- name: Ensure JBoss service is enabled and running
  systemd:
    name: jboss-domain
    state: started
    enabled: yes
    daemon_reload: yes

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']
  notify: restart jboss

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
  notify: restart jboss
EOF

clear
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss.service.j2 << 'EOF'
[Unit]
Description=JBoss EAP Domain Mode
After=network.target

[Service]
Type=forking
User={{ jboss_user }}
Group={{ jboss_group }}
ExecStart={{ jboss_home }}/bin/domain.sh
ExecStop={{ jboss_home }}/bin/jboss-cli.sh --connect :shutdown
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat ~/ansible-jboss-management/roles/jboss-management/templates/jboss.service.j2
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Copy custom startup script
  copy:
    content: |
      #!/bin/bash
      rm -rf master.log
      nohup $JBOSS_HOME/bin/domain.sh --domain-config=domain-cbo.xml --host-config=host-master-cbo-dev.xml > master.log &
      tail -f master.log
    dest: "{{ jboss_home }}/bin/domain-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']
  notify: restart jboss

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
  notify: restart jboss

- name: Ensure JBoss is running with custom script
  shell: "{{ jboss_home }}/bin/domain-start.sh"
  args:
    chdir: "{{ jboss_home }}/bin"
  when: inventory_hostname in groups['jboss_masters']
EOF

clear
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Copy custom startup script
  copy:
    content: |
      #!/bin/bash
      rm -rf master.log
      nohup $JBOSS_HOME/bin/domain.sh --domain-config=domain-cbo.xml --host-config=host-master-cbo-dev.xml > master.log &
      tail -f master.log
    dest: "{{ jboss_home }}/domain-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave-transact.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']
  notify: restart jboss

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-master-cbo-dev.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
  notify: restart jboss

- name: Ensure JBoss is running with custom script
  shell: "{{ jboss_home }}/domain-start.sh"
  args:
    chdir: "{{ jboss_home }}"
  when: inventory_hostname in groups['jboss_masters']
EOF

clear
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Copy custom startup script
  copy:
    content: |
      #!/bin/bash
      rm -rf master.log
      nohup $JBOSS_HOME/bin/domain.sh --domain-config=domain-cbo.xml --host-config=host-master-cbo-dev.xml > master.log &
      tail -f master.log
    dest: "{{ jboss_home }}/domain-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-master-cbo-dev.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
  notify: restart jboss

- name: Ensure JBoss is running with custom script
  shell: "{{ jboss_home }}/domain-start.sh"
  args:
    chdir: "{{ jboss_home }}"
  when: inventory_hostname in groups['jboss_masters']
EOF

clear
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
cat > ~/ansible-jboss-management/roles/jboss-management/files/jboss-aix-start.sh << 'EOF'
#!/bin/ksh

# JBoss EAP startup script for AIX
JBOSS_HOME={{ jboss_home }}
JBOSS_USER={{ jboss_user }}
LOG_FILE={{ jboss_home }}/logs/master.log

# Export necessary variables
export JAVA_HOME={{ java_home }}
export PATH=$JAVA_HOME/bin:$PATH

# Change to JBoss user and start the domain
su - $JBOSS_USER -c "
cd $JBOSS_HOME
rm -f $LOG_FILE
nohup bin/domain.sh --domain-config=domain-cbo.xml --host-config=host-master-cbo-dev.xml > $LOG_FILE 2>&1 &
"
EOF

cat > ~/ansible-jboss-management/roles/jboss-management/files/jboss-aix.subsys << 'EOF'
JBoss EAP Domain Controller
startsrc = "{{ jboss_home }}/bin/jboss-aix-start.sh"
stopsrc = "{{ jboss_home }}/bin/jboss-aix-stop.sh"
EOF

cat > ~/ansible-jboss-management/roles/jboss-management/files/jboss-aix-stop.sh << 'EOF'
#!/bin/ksh

# JBoss EAP stop script for AIX
JBOSS_HOME={{ jboss_home }}

# Stop JBoss domain
$JBOSS_HOME/bin/jboss-cli.sh --connect :shutdown
EOF

cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss-aix-start.sh.j2 << 'EOF'
#!/bin/ksh

# JBoss EAP startup script for AIX
JBOSS_HOME={{ jboss_home }}
JBOSS_USER={{ jboss_user }}
LOG_FILE={{ jboss_home }}/logs/master.log

# Export necessary variables
export JAVA_HOME={{ java_home | default('/usr/java8_64') }}
export PATH=$JAVA_HOME/bin:$PATH

# Change to JBoss user and start the domain
su - $JBOSS_USER -c "
cd $JBOSS_HOME
rm -f $LOG_FILE
nohup bin/domain.sh --domain-config=domain-cbo.xml --host-config=host-master-cbo-dev.xml > $LOG_FILE 2>&1 &
"
EOF

# Create AIX stop script template
cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss-aix-stop.sh.j2 << 'EOF'
#!/bin/ksh

# JBoss EAP stop script for AIX
JBOSS_HOME={{ jboss_home }}

# Stop JBoss domain
$JBOSS_HOME/bin/jboss-cli.sh --connect :shutdown
EOF

# Create SRC subsystem template
cat > ~/ansible-jboss-management/roles/jboss-management/templates/jboss-aix.subsys.j2 << 'EOF'
JBoss EAP Domain Controller
startsrc = "{{ jboss_home }}/bin/jboss-aix-start.sh"
stopsrc = "{{ jboss_home }}/bin/jboss-aix-stop.sh"
EOF

clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Check OS family
  fail:
    msg: "Unsupported OS family: {{ ansible_os_family }}"
  when: ansible_os_family != "AIX" and ansible_os_family != "RedHat" and ansible_os_family != "Debian"

- name: Copy AIX startup script
  template:
    src: "jboss-aix-start.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Copy AIX stop script
  template:
    src: "jboss-aix-stop.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-stop.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Create SRC subsystem for AIX
  template:
    src: "jboss-aix.subsys.j2"
    dest: "/etc/rc.subsys/jboss-domain"
    owner: root
    group: system
    mode: '0644'
  when: ansible_os_family == "AIX"

- name: Register SRC subsystem on AIX
  shell: |
    mkssys -s jboss-domain -p "{{ jboss_home }}/bin/jboss-aix-start.sh" -u {{ jboss_user }} -S -n 15 -f 9
  when: ansible_os_family == "AIX"

- name: Start JBoss service on AIX
  shell: |
    startsrc -s jboss-domain
  when: ansible_os_family == "AIX"

EOF

cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-passansible-playbook -i inventory/hosts site.yml --ask-become-pass
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Check OS family
  fail:
    msg: "Unsupported OS family: {{ ansible_os_family }}"
  when: ansible_os_family != "AIX" and ansible_os_family != "RedHat" and ansible_os_family != "Debian"

- name: Copy AIX startup script
  template:
    src: "jboss-aix-start.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Copy AIX stop script
  template:
    src: "jboss-aix-stop.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-stop.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Ensure /etc/rc.subsys directory exists on AIX
  file:
    path: /etc/rc.subsys
    state: directory
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Create SRC subsystem for AIX
  template:
    src: "jboss-aix.subsys.j2"
    dest: "/etc/rc.subsys/jboss-domain"
    owner: root
    group: system
    mode: '0644'
  when: ansible_os_family == "AIX"

- name: Register SRC subsystem on AIX
  shell: |
    mkssys -s jboss-domain -p "{{ jboss_home }}/bin/jboss-aix-start.sh" -u {{ jboss_user }} -S -n 15 -f 9
  when: ansible_os_family == "AIX"

- name: Start JBoss service on AIX
  shell: |
    startsrc -s jboss-domain
  when: ansible_os_family == "AIX"

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
EOF

ls -lrt
cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Check OS family
  fail:
    msg: "Unsupported OS family: {{ ansible_os_family }}"
  when: ansible_os_family != "AIX" and ansible_os_family != "RedHat" and ansible_os_family != "Debian"

- name: Copy AIX startup script
  template:
    src: "jboss-aix-start.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Copy AIX stop script
  template:
    src: "jboss-aix-stop.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-stop.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Ensure /etc/rc.subsys directory exists on AIX
  file:
    path: /etc/rc.subsys
    state: directory
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Create SRC subsystem for AIX
  template:
    src: "jboss-aix.subsys.j2"
    dest: "/etc/rc.subsys/jboss-domain"
    owner: root
    group: system
    mode: '0644'
  when: ansible_os_family == "AIX"

- name: Register SRC subsystem on AIX
  shell: |
    mkssys -s jboss-domain -p "{{ jboss_home }}/bin/jboss-aix-start.sh" -u {{ jboss_user }} -S -n 15 -f 9
  when: ansible_os_family == "AIX"

- name: Start JBoss service on AIX
  shell: |
    startsrc -s jboss-domain
  when: ansible_os_family == "AIX"

- name: Configure host controller
  template:
    src: "host-slave.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-slave.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_slaves']

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
EOF

ansible-playbook -i inventory/hosts site.yml --ask-become-pass
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Check OS family
  fail:
    msg: "Unsupported OS family: {{ ansible_os_family }}"
  when: ansible_os_family != "AIX" and ansible_os_family != "RedHat" and ansible_os_family != "Debian"

- name: Copy AIX startup script
  template:
    src: "jboss-aix-start.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Copy AIX stop script
  template:
    src: "jboss-aix-stop.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-stop.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Ensure /etc/rc.subsys directory exists on AIX
  file:
    path: /etc/rc.subsys
    state: directory
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Create SRC subsystem for AIX
  template:
    src: "jboss-aix.subsys.j2"
    dest: "/etc/rc.subsys/jboss-domain"
    owner: root
    group: system
    mode: '0644'
  when: ansible_os_family == "AIX"

- name: Register SRC subsystem on AIX
  shell: |
    mkssys -s jboss-domain -p "{{ jboss_home }}/bin/jboss-aix-start.sh" -u {{ jboss_user }} -S -n 15 -f 9
  when: ansible_os_family == "AIX"

- name: Start JBoss service on AIX
  shell: |
    startsrc -s jboss-domain
  when: ansible_os_family == "AIX"

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-master-cbo-dev.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
EOF

ansible-playbook -i inventory/hosts site.yml --ask-become-pass
ansible -i inventory/hosts dc1 -m shell -a "ls -ld /etc/rc.subsys" --become
sudo ansible -i inventory/hosts dc1 -m shell -a "ls -ld /etc/rc.subsys" --become
pwd
vi inventory/hosts 
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
clear
cat > ~/ansible-jboss-management/roles/jboss-management/tasks/main.yml << 'EOF'
---
- name: Ensure JBoss group exists
  group:
    name: "{{ jboss_group }}"
    state: present

- name: Ensure JBoss user exists
  user:
    name: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    state: present
    system: yes
    create_home: no

- name: Create JBoss installation directory
  file:
    path: "{{ jboss_home }}"
    state: directory
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'

- name: Check OS family
  fail:
    msg: "Unsupported OS family: {{ ansible_os_family }}"
  when: ansible_os_family != "AIX" and ansible_os_family != "RedHat" and ansible_os_family != "Debian"

- name: Copy AIX startup script
  template:
    src: "jboss-aix-start.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-start.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Copy AIX stop script
  template:
    src: "jboss-aix-stop.sh.j2"
    dest: "{{ jboss_home }}/bin/jboss-aix-stop.sh"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Ensure /etc/rc.subsys directory exists on AIX
  file:
    path: /etc/rc.subsys
    state: directory
    mode: '0755'
  when: ansible_os_family == "AIX"

- name: Create SRC subsystem for AIX
  template:
    src: "jboss-aix.subsys.j2"
    dest: "/etc/rc.subsys/jboss-domain"
    owner: root
    group: system
    mode: '0644'
  when: ansible_os_family == "AIX"

- name: Check if SRC subsystem already exists
  shell: |
    lssrc -s jboss-domain >/dev/null 2>&1 && echo "exists" || echo "does not exist"
  register: src_subsystem_status
  changed_when: false
  when: ansible_os_family == "AIX"

- name: Register SRC subsystem on AIX (if not exists)
  shell: |
    mkssys -s jboss-domain -p "{{ jboss_home }}/bin/jboss-aix-start.sh" -u {{ jboss_user }} -S -n 15 -f 9
  when: 
    - ansible_os_family == "AIX"
    - src_subsystem_status.stdout == "does not exist"

- name: Start JBoss service on AIX
  shell: |
    startsrc -s jboss-domain
  when: ansible_os_family == "AIX"

- name: Configure domain controller
  template:
    src: "host-master.xml.j2"
    dest: "{{ jboss_home }}/domain/configuration/host-master-cbo-dev.xml"
    owner: "{{ jboss_user }}"
    group: "{{ jboss_group }}"
    mode: '0640'
  when: inventory_hostname in groups['jboss_masters']
EOF

cd ~/ansible-jboss-management
ansible-playbook -i inventory/hosts site.yml --ask-become-pass
ansible dc1 -i inventory/hosts -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become
sudo ansible dc1 -i inventory/hosts -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become
clear
ansible dc1 -i inventory/hosts -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become -K
ansible 10.1.237.222 -i inventory/hosts -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become -K
ansible 10.1.237.222 -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become -K
sudo ansible 10.1.237.222 -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become -K
ansible 10.1.237.222 -m shell -a "/u01/T24/JBOSS/bin/jboss-aix-stop.sh" --become -K -vvv
clear
ls -lrt
ls
d 
clear
ls -lrt
cd ~/ansible-jboss-management
clear
ls -lrt
sudo apt update && sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
ls -lrt
cd ../
pwd
ls -lrt
git clone https://github.com/ansible/awx.git
cd awx/installer
ls -lrt
cd awx/
ls -lrt
cd config/
ls -lrt
cd ../
ls -lrt
pwd
cd ../
ls -lrt
cd awx/
kubectl apply -f https://github.com/ansible/awx-operator/releases/latest/download/awx-operator.yaml
sudo snap install kubectl
sudo snap install kubectl --classic
kubectl get pods -n default
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/
kind create cluster
sudo kind create cluster
kubectl cluster-info --context kind-kind
kubectl cluster-info --context kind
kubectl cluster-info
kubectl cluster-info --context kind-kind
kind version
kind create cluster
sudo kind create cluster
kind create cluster
clear
sudo kind create cluster
sudo kubectl cluster-info --context kind-kind
kubectl apply -f https://github.com/ansible/awx-operator/releases/latest/download/awx-operator.yaml
pwd
ls -lrt
sudo kubectl apply -f https://github.com/ansible/awx-operator/releases/latest/download/awx-operator.yaml
sudo kubectl get pods -n default
curl -Lo awx-operator.yaml https://github.com/ansible/awx-operator/releases/download/2.13.1/awx-operator.yaml
sudo kubectl get pods -n default
kubectl apply -f awx-operator.yaml
sudo kubectl apply -f awx-operator.yaml
kubectl apply -f awx-operator.yaml --validate=false
sudo kubectl apply -f awx-operator.yaml --validate=false
curl -Lo awx-operator-crds.yaml https://raw.githubusercontent.com/ansible/awx-operator/2.13.1/deploy/awx-operator-crds.yaml
curl -Lo awx-operator.yaml https://raw.githubusercontent.com/ansible/awx-operator/2.13.1/deploy/awx-operator.yaml
kubectl apply -f awx-operator-crds.yaml
kubectl apply -f awx-operator-crds.yaml --validate=false
pwd
cd ../
ls -lrt
kubectl apply -f awx-operator-crds.yaml --validate=false
cd awx/
ls -lrt
kubectl apply -f awx-operator-crds.yaml --validate=false
curl -Lo awx-operator-crds.yaml https://raw.githubusercontent.com/ansible/awx-operator/$VERSION/deploy/awx-operator-crds.yaml
ls -lrt
curl -Lo awx-operator.yaml https://raw.githubusercontent.com/ansible/awx-operator/$VERSION/deploy/awx-operator.yaml
head awx-operator-crds.yaml
VERSION=2.13.1
curl -Lo awx-operator-crds.yaml https://raw.githubusercontent.com/ansible/awx-operator/$VERSION/deploy/awx-operator-crds.yaml
curl -Lo awx-operator.yaml https://raw.githubusercontent.com/ansible/awx-operator/$VERSION/deploy/awx-operator.yaml
ls -lrt
head awx-operator-crds.yaml
curl -Lo awx-operator-crds.yaml https://raw.githubusercontent.com/ansible/awx-operator/2.13.1/deploy/awx-operator-crds.yaml
head awx-operator-crds.yaml
ls -lrt
vi kustomization.yaml
kustomize build . | kubectl apply -f -
sudo snap install kustomize
kustomize build . | kubectl apply -f -
ls -lrt
cat 
cat kustomization.yaml
kustomize build . | kubectl apply -f -
sudo snap remove kustomize
curl -LO "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v6.6.0/kustomize_v6.6.0_linux_amd64.tar.gz"
tar -xzf kustomize_v6.6.0_linux_amd64.tar.gz
ls -lrt
tar -xzf kustomize_v6.6.0_linux_amd64.tar.gz
file kustomize_v6.6.0_linux_amd64.tar.gz
tar -xvzf kustomize_v6.6.0_linux_amd64.tar.gz
gunzip kustomize_v6.6.0_linux_amd64.tar.gz
ls -lrt
pwd
ls -lrt
rm -rf kustomize_v6.6.0_linux_amd64.tar.gz
ls -lrt
pwd
ls -lrt
kustomize build . | kubectl apply -f -
tar -xzf kustomize_v5.7.1_linux_amd64.tar.gz
ls -lrt
sudo mv kustomize /usr/local/bin/
kustomize version
kustomize build . | kubectl apply -f -
kubectl config current-context
kubectl cluster-info
kustomize build . | kubectl apply -f - --validate=false
kind create cluster
sudo kind create cluster
kubectl cluster-info
kubectl config get-contexts
kubectl cluster-info dump
kind create cluster
kubectl get nodes
sudo kind create cluster
clear
sudo kind create cluster
kind get clusters
sudo kind get clusters
sudo kind delete cluster --name kind
sudo kind create cluster --name kind
kubectl cluster-info
kubectl cluster-info --context kind-kind
sudo kubectl cluster-info --context kind-kind
kubectl get nodes
kustomize build . | kubectl apply -f -
clear
docker ps
sudo docker ps
sudo usermod -aG docker $USER
sudo docker ps
docker ps
exit
cd ../
ls -lrt
cd cd /mnt/c/Users/naole/projects/my-k8s-app
cd c/
pwd
clera
clear
