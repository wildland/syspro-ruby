module Syspro
  module BusinessObjects
    module Models
      module PurchaseOrders
        class CommentLine
          attr_accessor :purchase_order_line,
                        :line_action_type,
                        :comment,
                        :attached_to_stk_line_number,
                        :delete_attached_comment_lines,
                        :change_single_comment_line
        end
      end
    end
  end
end
