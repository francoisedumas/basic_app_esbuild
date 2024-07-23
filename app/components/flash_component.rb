# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  TEXT_COLORS = {
    default: "text-indigo-500",
    success: "text-green-500",
    alert: "text-orange-500"
  }.freeze

  BG_COLORS = {
    default: "bg-indigo-500 border-indigo-700",
    success: "bg-green-500 border-green-700",
    alert: "bg-orange-400 border-orange-700"
  }.freeze

  def initialize(variant: :default)
    super
    @variant = variant
  end

  def render_svg
    @variant == :success ? svg_success : svg_alert
  end

  def text_classes
    variant = TEXT_COLORS.include?(@variant) ? @variant : :default
    TEXT_COLORS[variant]
  end

  def bg_classes
    variant = BG_COLORS.include?(@variant) ? @variant : :default
    BG_COLORS[variant]
  end

  private

  def svg_success
    <<-SVG.html_safe # rubocop:disable Rails/OutputSafety
      <svg width="1.8em" height="1.8em" viewBox="0 0 16 16" class="bi bi-check" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M10.97 4.97a.75.75 0 0 1 1.071 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.236.236 0 0 1 .02-.022" />
      </svg>
    SVG
  end

  def svg_alert
    <<-SVG.html_safe # rubocop:disable Rails/OutputSafety
      <svg width="1.8em" height="1.8em" viewBox="0 0 16 16" class="bi bi-exclamation" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z" />
      </svg>
    SVG
  end
end
