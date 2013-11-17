module Quickbooks
  module Model
    class InvoiceLineItem < BaseModel

      #== Constants
      SALES_LINE_ITEM_DETAIL = 'SalesItemLineDetail'
      SUB_TOTAL_LINE_DETAIL = 'SubTotalLineDetail'

      xml_accessor :id, :from => 'Id', :as => Integer
      xml_accessor :line_num, :from => 'LineNum', :as => Integer
      xml_accessor :description, :from => 'Description'
      xml_accessor :amount, :from => 'Amount', :as => Float
      xml_accessor :detail_type, :from => 'DetailType'

      #== Various detail types
      xml_accessor :sales_line_item_detail, :from => 'SalesItemLineDetail', :as => Quickbooks::Model::SalesItemLineDetail
      xml_accessor :subtotal_line_detail, :from => 'SubTotalLineDetail', :as => Quickbooks::Model::SubTotalLineDetail


      def sales_item?
        detail_type.to_s == SALES_LINE_ITEM_DETAIL
      end

      def subtotal_item?
        detail_type.to_s == SUB_TOTAL_LINE_DETAIL
      end

      def sales_item!
        self.detail_type = SALES_LINE_ITEM_DETAIL
        self.sales_line_item_detail = Quickbooks::Model::SalesItemLineDetail.new

        yield self.sales_line_item_detail if block_given?
      end

    end
  end
end