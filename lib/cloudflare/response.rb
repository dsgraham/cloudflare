module Cloudflare::Response

  class Base
    attr_accessor :body
    private :body

    def initialize(response)
      @body = response
    end

    def result(key)
      body[:result]&.fetch(key, nil)
    end

    def successful?
      body[:success]
    end

    def errors
      body[:errors]
    end

    def messages
      body[:messages]
    end

    def result_info
      body.fetch(:result_info, nil)
    end

  end

  class Account < Base
    attr_accessor :id, :name

    def initialize(response)
      super
      @id = result(:id)
      @name = result(:name)
    end
  end

  class Filter < Base
    attr_accessor :id, :expression, :paused

    def initialize(response)
      super
      @id = result(:id)
      @expression = result(:expression)
      @paused = result(:paused)
    end
  end

  class FirewallRule < Base
    attr_accessor :id, :paused, :description, :action, :priority, :filter

    def initialize(response)
      super
      @id = result(:id)
      @paused = result(:paused)
      @description = result(:description)
      @action = result(:action)
      @priority = result(:priority)
      @filter = Filter.new(result: result(:filter))
    end
  end

  class Owner < Base
    attr_accessor :id, :type, :email

    def initialize(response)
      super
      @id = result(:id)
      @type = result(:type)
      @email = result(:email)
    end
  end

  class Plan < Base
    attr_accessor :id, :name, :price, :currency, :frequency, :is_subscribed, :can_subscribe, :legacy_id,
                  :legacy_discount, :externally_managed

    def initialize(response)
      super
      @id = result(:id)
      @name = result(:name)
      @price = result(:price)
      @currency = result(:currency)
      @frequency = result(:frequency)
      @is_subscribed = result(:is_subscribed)
      @can_subscribe = result(:can_subscribe)
      @legacy_id = result(:legacy_id)
      @legacy_discount = result(:legacy_discount)
      @externally_managed = result(:externally_managed)
    end
  end

  class Zone < Base
    attr_accessor :id, :name, :status, :paused, :type, :development_mode, :name_servers, :original_name_servers,
                  :original_registrar, :original_dnshost, :modified_on, :created_on, :activated_on, :owner, :account,
                  :permissions, :plan

    def initialize(response)
      super
      @id = result(:id)
      @name = result(:name)
      @status = result(:status)
      @paused = result(:paused)
      @type = result(:type)
      @development_mode = result(:development_mode)
      @name_servers = result(:name_servers)
      @original_name_servers = result(:original_name_servers)
      @original_registrar = result(:original_registrar)
      @original_dnshost = result(:original_dnshost)
      @modified_on = result(:modified_on)
      @created_on = result(:created_on)
      @activated_on = result(:activated_on)
      @owner = Owner.new(result: result(:owner))
      @account = Account.new(result: result(:account))
      @permissions = result(:permissions)
      @plan = Plan.new(result: result(:plan))
    end
  end

end