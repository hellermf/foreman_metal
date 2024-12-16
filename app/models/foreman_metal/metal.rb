module ForemanMetal
  class Metal < ComputeResource
    include MetalConsole

    validates :wrapper, :presence => true

    def wrapper
      attrs[:wrapper]
    end

    def wrapper=(value)
      attrs[:wrapper] = value
    end

    def self.provider_friendly_name
      'Bare metal pseudo provider'
    end

    def self.model_name
      ComputeResource.model_name
    end

    def fakevms
      if @fakevms_ts && (elapsed = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - @fakevms_ts)) < 6000
        Foreman::Logging.logger('foreman_metal').debug "Returning cached info on #{@fakevms.length()} fakevms that is #{elapsed} seconds old"
      else
	@fakevms_ts = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        file = File.open "/usr/share/foreman/tmp/ipmi-inventory.json"
        ipmi = JSON.load file
        file.close
        x=0
        @fakevms = []
        ipmi.each do |i|
  	  @fakevms << ForemanMetal::FakeVM.new(i["name"], x += 1, i["ip"])
	end
        Foreman::Logging.logger('foreman_metal').debug "loaded info on #{fakevms.length()} fakevms from /usr/share/foreman/tmp/ipmi-inventory.json"
      end
      @fakevms
    end

    def initialize
      Foreman::Logging.logger('foreman_metal').debug "ForemanMetal::Metal initialize was called!"
    end

    def vms(opts = {})
      Foreman::Logging.logger('foreman_metal').debug "Returning #{fakevms.length()} fakevms"
      ForemanMetal::Vms.new(fakevms)
    end

    def associate_by(name, attributes)
      Foreman::Logging.logger('foreman_metal').debug "Trying to associate (fake)VM w/ #{name}=#{attributes} to a Foreman host profile"
      attributes = Array.wrap(attributes).map { |mac| Net::Validations.normalize_mac(mac) } if name == 'mac'
      Host.authorized(:view_hosts, Host).joins(:interfaces).
        where(ActiveRecord::Base.sanitize_sql("nics.#{name}") => attributes).
	where("nics.type" => "Nic::BMC").
        readonly(false).
        first
    end

    def associated_host(vm)
      associate_by('ip', vm.ip)
    end

    def find_vm_by_uuid(uuid)
      vm = nil
      Foreman::Logging.logger('foreman_metal').debug "Looking for VM with UUID #{uuid}..."
      fakevms.each do |fake|
	Foreman::Logging.logger('foreman_metal').debug "looking at #{fake.identity}"
	if fake.identity == uuid.split('_')[-1]
	  vm = fake
          Foreman::Logging.logger('foreman_metal').debug "...found it."
	  break
	end
      end
      Foreman::Logging.logger('foreman_metal').debug "Found: #{vm}"
      vm
    end
  end
end
