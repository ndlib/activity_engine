require 'spec_helper'

module ActivityEngine
  describe Activity do
    subject { ActivityEngine::Activity.new }
    let(:object) { PersistenceLayer.new }

    describe 'finder scopes' do
      it 'should have .descending_date' do
        expect(ActivityEngine::Activity.descending_date).to be_kind_of(ActiveRecord::Relation)
      end
      it 'should have .ascending_date' do
        expect(ActivityEngine::Activity.ascending_date).to be_kind_of(ActiveRecord::Relation)
      end
      it 'should have .for_user' do
        expect(ActivityEngine::Activity.for_user(nil)).to be_kind_of(ActiveRecord::Relation)
      end
      it 'should have .for_subject' do
        expect(ActivityEngine::Activity.for_subject(object)).to be_kind_of(ActiveRecord::Relation)
      end
      it 'should have .for_activity_type' do
        expect(ActivityEngine::Activity.for_activity_type('Hello#World')).to be_kind_of(ActiveRecord::Relation)
      end
    end

    describe '.statistics_for_subject' do
      let(:stats_builder) {
        {"hello" => 3, "good_bye" => 2}
      }
      before(:each) do
        stats_builder.each do |activity_type, times|
          (1..times).each {
            ActivityEngine::Activity.create { |a|
              a.subject = object; a.activity_type = activity_type
            }
          }
        end
      end

      it 'returns an array of statistics' do
        stats = ActivityEngine::Activity.statistics_for_subject(object)
        expect(stats.size).to eq(stats_builder.size)

        stats.each do |stat|
          expected_count = stats_builder.fetch(stat.activity_type)
          expect(stat.count).to eq(expected_count)
          expect(stat).to respond_to(:last_activity_date)
        end
      end
    end

    describe '#subject=' do
      describe 'with persisted object' do
        it 'should marshal the subject' do
          subject.subject = object
          expect(subject.subject).to eq(object)
        end

        it 'should capture the subject id' do
          subject.subject = object
          expect(subject.subject_id).to eq(object.to_param)
        end

        it 'should capture the subject type' do
          subject.subject = object
          expect(subject.subject_type).to eq(object.class.to_s)
        end
      end

      describe 'with a non persisted object' do
        it 'raise exception if the object is not persisted' do
          def object.persisted?; false; end
          expect {
            subject.subject = object
          }.to raise_error(ActivityEngine::UnpersistedSubjectError)
        end

        it 'raise exception if the object does not respond to persisted' do
          expect {
            subject.subject = 2
          }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
