class IpRestrictMiddleware
    def initialize(app)
        # tham số app này là một instance của App chat khi ứng dụng được run
        @app = app
    end

    def call(env)
        allowed_ips = ['127.0.0.1', '192.168.0.101']

        user_ip = env['REMOTE_ADDR']

        if allowed_ips.include?(user_ip)
            # method call này khác với method call của class
            @app.call(env)
        else
            [403, {'Content-Type' => 'text/plain'}, ['Forbidden']]
        end
    end
end
