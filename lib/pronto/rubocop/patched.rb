require "pronto/rubocop/patched/version"

module Pronto
  module Rubocop
    class Patched < Runner
      def run
        return [] unless @patches

        @patches
          .select { |patch| patch.additions.positive? }
          .flat_map { |patch| PatchCop.new(patch, self).messages }
      end

      def pronto_rubocop_config
        @pronto_rubocop_config ||= Pronto::ConfigFile.new.to_h['rubocop'] || {}
      end
    end
  end
end
