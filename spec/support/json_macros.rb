module JsonMacros
  def json_response
    json_body = JSON.parse(response.body)

    if json_body.is_a?(Hash)
      json_body.with_indifferent_access
    else
      json_body.map(&:with_indifferent_access)
    end
  end

  def get_json(path, params, other)
    get(path, params.merge(:format => :json), other)
  end

  def put_json(path, params, other)
    put(path, params.merge(:format => :json), other)
  end

  def post_json(path, params, other)
    post(path, params.merge(:format => :json), other)
  end

  def delete_json(path, params, other)
    delete(path, params.merge(:format => :json), other)
  end
end

RSpec.configure {|config| config.include(JsonMacros, :type => :controller) }
