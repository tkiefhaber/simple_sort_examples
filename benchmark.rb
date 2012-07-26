require 'benchmark'
require './merge_sort'
require './quick_sort'

puts "Generating data..."
data = (1..6).map do |e|
  [a=(0...10**e).to_a.shuffle, a.dup, a.dup, a.dup, a.dup]
end
puts "Running benchmarks..."

data.each do |set|
  puts "\nData set with #{set.first.length} elements:"
  Benchmark.bm(20) do |b|
    b.report("mergesort")          { MergeSort.sort(set.shift) }
    b.report("quicksort:simple")   { QuickSort::Simple.sort(set.shift) }
    b.report("quicksort:in place") { QuickSort::InPlace.sort(set.shift) }
    b.report("native sort")        { set.shift.sort }
    b.report("native in-place sort")        { set.shift.sort! }
  end
end

puts "Generating data..."
lengths = (1..10).map { |n| 10000 * n }
data = lengths.map do |len|
  (0...len).to_a.shuffle
end
puts "Running benchmarks..."

Benchmark.bm(20) do |b|
  lengths.each do |len|
    b.report("quicksort:simple #{len}") { QuickSort::Simple.sort(data.shift) }
  end
end

