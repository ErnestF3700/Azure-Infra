module "resource_group" {
  source = "../../modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = var.tags

  management_lock_enabled = false
}


module "hub_vnet" {
  source = "../../modules/vnet"

  name                = "vnet-hub-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  address_space = var.hub_address_space

  tags = var.tags
}


module "spoke_vnet" {
  source = "../../modules/vnet"

  name                = "vnet-app-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  address_space = var.spoke_address_space

  tags = var.tags
}


module "hub_to_spoke" {
  source = "../../modules/vnet_peering"

  name                      = "peer-hub-to-app-${var.environment}-weu"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.hub_vnet.name
  remote_virtual_network_id = module.spoke_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}


module "spoke_to_hub" {
  source = "../../modules/vnet_peering"

  name                      = "peer-app-to-hub-${var.environment}-weu"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.spoke_vnet.name
  remote_virtual_network_id = module.hub_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
}


# ============================================================
## HUB SUBNETS 
# ============================================================

module "hub_management_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-management"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "hub_firewall_subnet" {
  source = "../../modules/subnet"

  name                 = "AzureFirewallSubnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.hub_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "hub_bastion_subnet" {
  source = "../../modules/subnet"

  name                 = "AzureBastionSubnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.hub_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

module "hub_gateway_subnet" {
  source = "../../modules/subnet"

  name                 = "GatewaySubnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.hub_vnet.name
  address_prefixes     = ["10.0.4.0/27"]
}

# ============================================================
## SPOKE SUBNETS
# ============================================================
module "spoke_aks_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-aks"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.spoke_vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

module "spoke_vm_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-vm"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.spoke_vnet.name
  address_prefixes     = ["10.10.2.0/24"]
}

module "spoke_private_endpoint_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-private-endpoints"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.spoke_vnet.name
  address_prefixes     = ["10.10.3.0/24"]
}

module "spoke_app_subnet" {
  source = "../../modules/subnet"

  name                 = "snet-app"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.spoke_vnet.name
  address_prefixes     = ["10.10.4.0/24"]
}


# ============================================================
## NSG 
# ============================================================

module "hub_management_nsg" {
  source = "../../modules/nsg"

  name                = "nsg-management-${var.environment}-weu"
  location            = var.location
  resource_group_name = module.resource_group.name

  tags = var.tags
}

module "spoke_vm_nsg" {
  source = "../../modules/nsg"

  name                = "nsg-vm-${var.environment}-weu"
  location            = var.location
  resource_group_name = module.resource_group.name

  tags = var.tags
}

module "spoke_app_nsg" {
  source = "../../modules/nsg"

  name                = "nsg-app-${var.environment}-weu"
  location            = var.location
  resource_group_name = module.resource_group.name

  tags = var.tags
}

module "spoke_private_endpoint_nsg" {
  source = "../../modules/nsg"

  name                = "nsg-private-endpoints-${var.environment}-weu"
  location            = var.location
  resource_group_name = module.resource_group.name

  tags = var.tags
}



# ============================================================
# NSG RULES
# ============================================================

# ============================================================
# NSG RULES
# ============================================================

resource "azurerm_network_security_rule" "management_allow_ssh" {
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resource_group.name
  network_security_group_name = module.hub_management_nsg.name
}

resource "azurerm_network_security_rule" "management_allow_rdp" {
  name                        = "allow-rdp"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resource_group.name
  network_security_group_name = module.hub_management_nsg.name
}

resource "azurerm_network_security_rule" "vm_allow_ssh" {
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.resource_group.name
  network_security_group_name = module.spoke_vm_nsg.name
}

resource "azurerm_network_security_rule" "app_allow_http" {
  name                        = "allow-http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = module.resource_group.name
  network_security_group_name = module.spoke_app_nsg.name
}

resource "azurerm_network_security_rule" "app_allow_https" {
  name                        = "allow-https"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = module.resource_group.name
  network_security_group_name = module.spoke_app_nsg.name
}


# ============================================================
# NSG ASSOCIATIONS
# ============================================================

module "hub_management_nsg_association" {
  source = "../../modules/nsg_association"

  subnet_id                 = module.hub_management_subnet.id
  network_security_group_id = module.hub_management_nsg.id
}

module "spoke_vm_nsg_association" {
  source = "../../modules/nsg_association"

  subnet_id                 = module.spoke_vm_subnet.id
  network_security_group_id = module.spoke_vm_nsg.id
}

module "spoke_app_nsg_association" {
  source = "../../modules/nsg_association"

  subnet_id                 = module.spoke_app_subnet.id
  network_security_group_id = module.spoke_app_nsg.id
}

module "spoke_private_endpoint_nsg_association" {
  source = "../../modules/nsg_association"

  subnet_id                 = module.spoke_private_endpoint_subnet.id
  network_security_group_id = module.spoke_private_endpoint_nsg.id
}



# ============================================================
# ROUTE TABLES
# ============================================================
module "spoke_route_table" {
  source = "../../modules/route_table"

  name                = "rt-spoke-${var.environment}-weu"
  location            = var.location
  resource_group_name = module.resource_group.name

  tags = var.tags
}


module "spoke_vm_route_table_association" {
  source = "../../modules/route_table_association"

  subnet_id      = module.spoke_vm_subnet.id
  route_table_id = module.spoke_route_table.id
}

module "spoke_app_route_table_association" {
  source = "../../modules/route_table_association"

  subnet_id      = module.spoke_app_subnet.id
  route_table_id = module.spoke_route_table.id
}


# ============================================================
# FIREWALL POLICY
# ============================================================

module "firewall_policy" {
  source = "../../modules/firewall_policy"

  name                = "fwp-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  sku                      = "Standard"
  threat_intelligence_mode = "Alert"

  tags = var.tags
}

# ============================================================
# FIREWALL PUBLIC IP
# ============================================================

module "firewall_public_ip" {
  source = "../../modules/public_ip"

  name                = "pip-firewall-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

# ============================================================
# AZURE FIREWALL
# ============================================================

module "azure_firewall" {
  source = "../../modules/azure_firewall"

  name                = "azfw-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  firewall_policy_id = module.firewall_policy.id

  ip_configuration = {
    name                 = "ipconfig-firewall"
    subnet_id            = module.hub_firewall_subnet.id
    public_ip_address_id = module.firewall_public_ip.id
  }

  tags = var.tags
}
