Before do
    @methods = Methods.new
end

After do |scn|
    file_name = scn.name.gsub(' ', '_').downcase!
    target = "data/screenshots/#{file_name}.png"
    if scn.failed?
      page.save_screenshot(target)
      embed(target, 'image/png', 'Evidência')
    else
      page.save_screenshot(target)
      embed(target, 'image/png', 'Evidência')
    end
    page.driver.quit
end

at_exit do
    ReportBuilder.configure do |config|
        config.input_path = 'data/report/report.json'
        config.report_path = 'data/report/estrategia_educacao_report'
        config.report_types = [:retry, :html]
        config.report_title = 'Estratégia Educação'
        config.include_images = true
        config.color = 'blue'
        config.additional_info = {Ambiente: "https://www.estrategiaconcursos.com.br/"}
      end
      ReportBuilder.build_report  
end