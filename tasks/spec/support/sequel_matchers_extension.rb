# frozen_string_literal: true

module SequelMatchersExtension
  module ::RspecSequel
    module Matchers
      class HaveOneThroughOneMatcher < RspecSequel::Association
        def association_type
          :one_through_one
        end

        def valid?(db, i, c, attribute, options)
          super

          # check that association model exists, etc.
        end
      end

      def have_one_through_one(*args)
        HaveOneThroughOneMatcher.new(*args)
      end
    end
  end
end
