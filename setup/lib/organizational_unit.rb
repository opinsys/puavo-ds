class OrganizationalUnit < ActiveLdap::Base  
  ldap_mapping( :dn_attribute => "ou",
                :prefix => "dc=edu",
                :classes => ['top', 'organizationalUnit'] )

  def self.create_units(organisation)
    ['People',
     'Groups',
     'Automount',
     'Roles',
     'Services',
     'System Accounts',
     'System Groups',
     'Password Policies',
     'Idmap',
     'Kerberos Realms'].each do |ou|
      OrganizationalUnit.create( "ou" => ou )
    end
    
    OrganizationalUnit.create( "ou" => 'Hosts',
                               "objectClass" => ['top', 'organizationalUnit', 'puppetClient'],
                               "parentNode" =>  organisation.puavoDomain )
      
    self.ldap_mapping( :dn_attribute => "ou",
                       :prefix => "ou=Hosts,dc=edu",
                       :classes => ['top', 'organizationalUnit'] )
    ['Servers',
     'Devices'].each do |ou|
      OrganizationalUnit.create( "ou" => ou )
    end
  end
end