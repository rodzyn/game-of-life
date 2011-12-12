require './gameoflife'

describe 'game of life' do
  let(:world){ World.new }
  describe 'world initialization' do
    it "should have no cells" do
      world.cells.should == []
    end
  end

  describe 'basic functionality' do
    it "should have cells" do
      world.add_cell(1, 3)
      world.add_cell(-2, 0)
      world.add_cell(1, 5)
      world.cells.count.should == 3
    end

    it "should check existence of cell" do
      world.add_cell(1, 3)
      world.cell_exists?(1, 3).should be_true
      world.cell_exists?(1, 4).should be_false
    end

    it "should count neighbors" do
      world.add_cell(-1, 0)
      world.add_cell(0, 0)
      world.add_cell(1, 0)

      world.count_neighbors(0, 0).should == 2
      world.count_neighbors(1, 0).should == 1
      world.count_neighbors(0, -1).should == 3
      world.count_neighbors(0, 1).should == 3
    end
  end

  describe 'rules' do
    describe 'underpopulation' do
      it 'should kill cell' do
        world.add_cell(0, 0)
        world.tick!
        world.cells.count.should == 0
      end
    end

    describe 'overpopulation' do
      it 'should kill cell' do
        world.add_cell(0, 0)
        world.add_cell(0, 1)
        world.add_cell(0, 2)
        world.add_cell(1, 1)
        world.add_cell(1, 2)
        world.tick!
        world.cell_exists?(0, 1).should be_false
        world.cell_exists?(1, 1).should be_false
      end
    end

    describe 'dead cell with neighbors' do
      it 'should be alive' do
        world.add_cell(0, 0)
        world.add_cell(-1, 0)
        world.add_cell(1, 0)
        world.tick!
        world.cell_exists?(0, 1).should be_true
      end
    end

    describe 'save cell' do
      it 'should stay in generation' do
        world.add_cell(0, 0)
        world.add_cell(-1, 0)
        world.add_cell(1, 0)
        world.tick!
        world.cell_exists?(0, 1).should be_true
        world.cell_exists?(0, 0).should be_true
        world.cell_exists?(0, -1).should be_true
      end
    end
  end
end