# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2012/05/29

module Milkode
  class PackageTable
    include Enumerable

    def self.define_schema
      Groonga::Schema.define do |schema|
        schema.create_table("packages", :type => :hash) do |table|
          table.string("name")
          table.time("addtime")
          table.time("updatetime")
          table.time("viewtime")
          table.time("favtime")
        end
      end
    end

    def initialize(table)
      @table = table
    end

    def size
      @table.size
    end

    def add(name)
      @table.add(name, :name => name, :addtime => Time.now)
    end

    def remove(name)
      @table[name].delete
    end

    def remove_all
      self.each do |r|
        r.record_id.delete
      end
    end

    def [](name)
      @table[name]
    end

    def each
      @table.select.each do |r|
        yield r
      end
    end

    def sort(kind, order = "descending")
      @table.sort([{:key => kind, :order => order}])
    end

    def dump
      self.each do |r|
        p [r.name, r.addtime, r.updatetime, r.viewtime, r.favtime]
      end
    end

    def touch(name, kind, time = Time.now)
      @table[name][kind] = time
    end

    def favs
      sorted = sort('favtime')
      zero_time = Time.at(0)
      index = sorted.find_index {|v| v.favtime == zero_time}
      unless index.nil?
        sorted[0...index]
      else
        sorted
      end
    end
  end
end


