# -*- encoding : utf-8 -*-
class Admin::TestBrandsController < Admin::BaseController
  before_filter :admin_required

  def index
    @test_brands = TestBrand.order("test_brands.id desc").paginate(:per_page => 20, :page => params[:page])
    @test_brands = @test_brands.where('test_brands.code = ?', params[:search_code]) unless params[:search_code].blank?
    @test_brands = @test_brands.where('test_brands.name like ?', '%' + params[:search_name] + '%') unless params[:search_name].blank?
    @test_brands = @test_brands.where('test_brands.korea_name like ?', '%' + params[:search_korea_name] + '%') unless params[:search_korea_name].blank?
    # 라인업 존재여부 검색
    unless params[:search_line_up].blank?
      @test_brands = params[:search_line_up] == "1" ? @test_brands.where('test_brands.linup_count > 0') : @test_brands.where('test_brands.linup_count = 0')
    end
    # 생성일자 검색
    @test_brands = @test_brands.where("Date_format(test_brands.created_at, '%Y%m%d') >= ?", params[:created_at_start].gsub('-', '')) unless params[:created_at_start].blank?
    @test_brands = @test_brands.where("Date_format(test_brands.created_at, '%Y%m%d') <= ?", params[:created_at_end].gsub('-', '')) unless params[:created_at_end].blank?

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @test_brand = TestBrand.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @test_brand }
    end
  end

  def edit
    @test_brand = TestBrand.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @test_brand }
    end
  end

  def create
    @test_brand = TestBrand.new(params[:test_brand])

    respond_to do |format|
      if @test_brand.save
        format.html { redirect_to admin_test_brands_path, notice: 'TestBrand was successfully created.' }
        format.json { render json: @test_brand, status: :created, location: @test_brand }
      else
        format.html { render action: "new" }
        format.json { render json: @test_brand.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @test_brand = TestBrand.find(params[:id])

    respond_to do |format|
      if @test_brand.update_attributes(params[:test_brand])
        format.html { redirect_to admin_test_brands_path, :notice => 'Test Brand was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @test_brand.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @test_brand = TestBrand.find(params[:id])
    @test_brand.destroy

    respond_to do |format|
      format.html { redirect_to admin_test_brands_path, :notice => 'Test Brand was deleted.' }
      format.json { head :no_content }
    end
  end
  # 중복코드 체크
  def code_list
    #/admin/product/test_brand/code_list.json?&code=112
    #remove_space 를 처리해서 검색 할때도 띄워쓰기 지워서 검색
    code = params[:code].gsub(" ","").strip
    exact = params[:exact]
    serch_id = params[:serch_id]  # 파트너 SKU 중복 조회 시 상품메타 아이디를 조회
    result = {}
    @code_list = TestBrand.select("code")
    #unless code.blank? #완전일치 또는 like 검색
    unless code.to_s.length == 0
      @code_list = (exact == 'y') ? @code_list.where("test_brands.code = ?", code.to_s) : @code_list.where("test_brands.code like ?", '%' + code.to_s + '%')
    end

    code_list = (@code_list.map &:code).as_json
    #code_list = (TestBrand.select("code").map &:code).as_json
    render :json => code_list.map { |code| code }
  end
end

