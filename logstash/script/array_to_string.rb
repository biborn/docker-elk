# the value of `params` is the value of the hash passed to `script_params`
# in the logstash configuration
def register(params)
        @filter_field = params["filter"]
        @return_field = params["return"]
end

def filter(event)
    b = []
	event.get(@filter_field).each { |k|
		o = {}
		k.each { |n,m|
		  o[n.gsub(/(.)([A-Z])/,'\1_\2').downcase] = m[0]
		}
		o.delete('uid')
		b << o
	}
	event.set(@return_field, b)

	return [event]
end
