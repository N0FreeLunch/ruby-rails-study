class ViewToDisplayController < ApplicationController
  def sampleView
    @description = '컨트롤러에서 전달된 문자열 값입니다.'
  end
end
