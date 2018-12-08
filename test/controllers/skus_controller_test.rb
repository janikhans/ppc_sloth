require 'test_helper'

class SkusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sku = skus(:one)
  end

  test "should get index" do
    get skus_url
    assert_response :success
  end

  test "should get new" do
    get new_sku_url
    assert_response :success
  end

  test "should create sku" do
    assert_difference('Sku.count') do
      post skus_url, params: { sku: { asin: @sku.asin, name: @sku.name } }
    end

    assert_redirected_to sku_url(Sku.last)
  end

  test "should show sku" do
    get sku_url(@sku)
    assert_response :success
  end

  test "should get edit" do
    get edit_sku_url(@sku)
    assert_response :success
  end

  test "should update sku" do
    patch sku_url(@sku), params: { sku: { asin: @sku.asin, name: @sku.name } }
    assert_redirected_to sku_url(@sku)
  end

  test "should destroy sku" do
    assert_difference('Sku.count', -1) do
      delete sku_url(@sku)
    end

    assert_redirected_to skus_url
  end
end
