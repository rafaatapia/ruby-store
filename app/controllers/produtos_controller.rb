class ProdutosController < ApplicationController

  before_action :set_produto, only: [:edit, :update, :destroy]

  def index
     @produtosByNome = Produto.order(:nome).limit 5
     @produtosByPreco = Produto.order(:preco).limit 2
  end

  def create
    @produto = Produto.new produto_params

    if @produto.save
        flash[:notice] = "Produto salvo com sucesso!"
        redirect_to root_url
    else
      renderiza :new
    end
  end

  def edit
    renderiza :edit
  end

  def update
    if @produto.update produto_params
      flash[:notice] = "Produto atualizado com sucesso!"
      redirect_to root_url
    else
      renderiza :new
    end
  end

  def new
    @produto = Produto.new
    renderiza :new
  end

  def destroy
    @produto.destroy
    redirect_to root_url
  end

  def busca
    @nome_a_buscar = params[:nome]
    @produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
  end

  private

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end

  def set_produto
    id = params[:id]
    @produto = Produto.find(id)
  end

  def produto_params
    params.require(:produto).permit :nome, :descricao, :quantidade, :preco, :departamento_id
  end

end
