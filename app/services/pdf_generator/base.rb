# frozen_string_literal: true

module PdfGenerator
  class Base
    ADAPTER = "grover"

    attr_reader :template, :locals

    def initialize(template:, locals:)
      @template = template
      @locals = locals
    end

    def self.generate_now(template:, locals:)
      adapter_class.new(template:, locals:).generate_now
    end

    def generate_now
      raise NotImplementedError
    end

    def self.adapter_class
      "::PdfGenerator::#{ADAPTER.to_s.classify}".constantize
    end

    private

    def html_content
      ActionController::Base.new.render_to_string(
        template:,
        layout:,
        locals:
      )
    end

    def layout
      raise NotImplementedError
    end
  end
end
