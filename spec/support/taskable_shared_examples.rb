shared_examples "taskable" do |taskable_type|

  let(:scope) { mock }

  describe "#tasks" do
    let(:fetch_scope) { mock }

    it "passes the token and applies the params" do
      subject.
        should_receive(:pass_headers).
        with(BaseCrm::Task).
        and_return(scope)
      scope.should_receive(:params).
        with({
          :noteable_type => taskable_type,
          :noteable_id => subject.id
        }).and_return(fetch_scope)
      subject.tasks.should == fetch_scope
    end

  end

  describe "#create_task" do
    let(:params) do
      { :content => task_content }
    end
    let(:task_content) { mock }
    let(:task) { mock }

    it "creates a new task" do
      subject.
        should_receive(:pass_headers).
        with(BaseCrm::Task).
        and_return(scope)
      scope.should_receive(:create).with({
        :content => task_content,
        :noteable_type => taskable_type,
        :noteable_id => subject.id
      }).and_return(task)
      subject.create_task(params).should == task
    end

  end

end

