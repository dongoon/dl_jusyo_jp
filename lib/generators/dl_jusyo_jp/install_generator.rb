module DlJusyoJp
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates migrations for ddress tables (download & your app use)."
      class_option :orm

      def self.source_root
        File.expand_path("../templates", __FILE__)
      end

      def copy_initializer
        template '../templates/initializers/dl_jusyo_jp.rb', 'config/initializers/dl_jusyo_jp.rb'
      end

      def copy_models
        Dir["#{self.class.source_root}/models/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          to_path = 'app/models'
          template("models/#{name}", "#{to_path}/#{name}")
        end
      end

      def create_migrations
        Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          to_path = 'db/migrate'
          # TODO: something wrong...
          if Dir.glob("#{to_path}/[0-9]*_*.rb").grep(/\d+_#{name}$/).blank?
            template("migrations/#{name}", "#{to_path}/#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_#{name}")
          end
        end
      end
    end
  end
end
