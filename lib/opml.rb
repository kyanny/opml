require 'opml/version'
require 'rexml/document'

require 'rubygems'
require 'active_support/all'

class Opml
  class Outline
    attr_accessor :attributes, :outlines

    def initialize(element)
      @attributes = map_attributes_to_hash(element.attributes)
      @outlines = element.elements.map { |element| Outline.new(element) }
    end

    def flatten
      @flatten ||= @outlines.map(&:flatten).flatten.unshift(self)
    end

    def to_s
      @to_s ||= attributes['text'] || super
    end

    def respond_to?(method)
      return true if attributes[method.to_s]
      super
    end

    def method_missing(method, *args, &block)
      attributes[method.to_s] || super
    end

    private
      def map_attributes_to_hash(attributes)
        {}.tap do |hash|
          attributes.each { |key, value| hash[key.underscore] = value }
        end
      end
  end

  attr_reader :outlines

  def initialize(xml)
    @doc = REXML::Document.new(xml)

    parse_head_elements :title, :owner_name, :owner_email
    parse_head_elements :date_created, :date_modified, :with => Proc.new { |e|
      begin
        Time.parse(e)
      rescue ArgumentError
        nil
      end
    }

    @outlines = document_body ? initialize_outlines_from_document_body : []
  end

  def flatten
    @flatten ||= @outlines.map(&:flatten).flatten
  end

  private
    def parse_head_elements(*elements)
      options = elements.last.is_a?(Hash) ? elements.pop : {}
      elements.each do |attribute|
        define_head_attr_reader(attribute)
        set_head_value(attribute, options)
      end
    end

    def define_head_attr_reader(attribute)
      self.class.send(:attr_reader, attribute)
    end

    def get_head_value(attribute)
      if element = @doc.elements["opml/head/#{attribute.to_s.camelize(:lower)}"]
        element.text
      end
    end

    def parse_value(value, options)
      options[:with] ? options[:with].call(value) : value
    end

    def set_head_value(attribute, options)
      if value = get_head_value(attribute)
        instance_variable_set("@#{attribute}", parse_value(value, options))
      end
    end

    def document_body
      @document_body ||= @doc.elements['opml/body']
    end

    def initialize_outlines_from_document_body
      document_body.elements.map { |element| Outline.new(element) }
    end
end
