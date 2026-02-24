# helpers/pagination_helper.rb
require 'cgi'

module PaginationHelper
  def pagination_links(collection, window: 2, param_name: :page)
    return if collection.page_count <= 1

    total_pages = collection.page_count
    current     = collection.current_page
    start_page  = [current - window, 1].max
    end_page    = [current + window, total_pages].min

    # Parámetros actuales sin el de página
    base_params = request.GET.dup
    base_params.delete(param_name.to_s)

    # Generador de enlaces
    link_to_page = lambda do |page_num, text, extra_class = ""|
      params = base_params.merge(param_name.to_s => page_num)
      query_string = params.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }.join("&")
      url = request.path + (query_string.empty? ? "" : "?" + query_string)
      %(<a href="#{url}" class="px-3 py-2 text-[10px] font-black uppercase tracking-widest border-r border-[var(--border-color)] hover:bg-[var(--border-color)] transition-colors #{extra_class}">#{text}</a>)
    end

    html = <<~HTML
      <div class="bg-[var(--bg-body)] p-4 border-t border-[var(--border-color)] flex flex-col md:flex-row justify-between items-center gap-4">
        <span class="text-[10px] font-black uppercase tracking-widest text-[var(--text-muted)]">
          Página #{current} de #{total_pages}
        </span>
        <div class="flex rounded-lg overflow-hidden border border-[var(--border-color)] bg-white">
    HTML

    # Anterior
    unless collection.first_page?
      html << link_to_page.call(current - 1, "←")
    end

    # Primera página + ...
    if start_page > 1
      html << link_to_page.call(1, "1")
      if start_page > 2
        html << %(<span class="px-3 py-2 text-[10px] border-r border-[var(--border-color)]">...</span>)
      end
    end

    # Ventana central
    (start_page..end_page).each do |p|
      if p == current
        html << %(<span class="px-3 py-2 text-[10px] font-black uppercase tracking-widest bg-[var(--border-color)] border-r border-[var(--border-color)]">#{p}</span>)
      else
        html << link_to_page.call(p, p.to_s)
      end
    end

    # Última página + ...
    if end_page < total_pages
      if end_page < total_pages - 1
        html << %(<span class="px-3 py-2 text-[10px] border-r border-[var(--border-color)]">...</span>)
      end
      html << link_to_page.call(total_pages, total_pages.to_s)
    end

    # Siguiente
    unless collection.last_page?
      html << link_to_page.call(current + 1, "→")
    end

    html << "</div></div>"
    html.html_safe
  end
end