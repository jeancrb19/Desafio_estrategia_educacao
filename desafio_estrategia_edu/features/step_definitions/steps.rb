Dado("que estou na pagina inicial") do
  @methods.acessar_site
end

Dado("utilizo a busca {string}") do |nome_busca|
    find('a', text: "#{nome_busca}").click
end

Dado("busco por {string}") do |name|
    @x = name
  within('.search') do
    find('input').set(name)
    sleep(3)
    assert_no_text('Carregando...')
    find('input', wait: 10).send_keys(:enter) 
  end
end

Quando("acesso um curso da listagem") do
    within('.card-prod.-padded', text: @x) do
        find('.card-prod-details.-blue').click
      end
    
      $valor_listagem = first('.card-prod-price').text 
      $valor_listagem = $valor_listagem.split("$ ")[1] 
      $valor_listagem = $valor_listagem.gsub(",", ".")
      $valor_listagem = $valor_listagem.to_f    
end

Então("valido todos detalhes do curso") do
    first('.card-prod-details').click
    valor_total = find('.value').text
    valor_total = valor_total.delete("R$").delete(".").gsub(",", ".").to_f   
    valor_dividido = valor_total/12
    
    valor_parcela = find('.cur-details-shopping-installments').text
    valor_parcela = valor_parcela.split("$ ")[1] 
    valor_parcela = valor_parcela.gsub(",", ".")
    valor_parcela = valor_parcela.to_f 
    raise "Valor da listagem diferente do valor da parcela" if $valor_listagem != valor_parcela
    raise "Valor do parcelamento incorreto" if valor_dividido != valor_parcela
end

Quando("visualizo a tela de detalhes") do
    within('.card-prod.-padded', text: 'Matemática', match: :prefer_exact) do 
        $qtd_listagem = find('.card-prod-available').text
        $qtd_listagem = $qtd_listagem.delete('^0-9').to_i 
        find('.card-prod-details.-blue').click
    end
    
    within('.container', text: 'Matemática', match: :prefer_exact) do 
        $qtd_detalhes = find('.text').text
        $qtd_detalhes = $qtd_detalhes.delete('^0-9').to_i
    end
  end
  
  Então("valido a quantidade de cursos exibidas") do
    raise "As quantidades de cursos exibidas na listagem e no detalhe são diferentes" if $qtd_listagem != $qtd_detalhes
  end

  Quando("seleciono {string}") do |regiao|
    @regiao = regiao
    find('a', text: "#{@regiao}").click 
  end
  
  Então("visualizo a tela com todos concursos da região escolhida") do
    assert_text("#{@regiao}")
    within('.page-result-list') do 
        assert_selector('.card-prod.-padded')
    end
  end