class JobTenure {
  final String id;
  final String name;

  JobTenure({required this.id, required this.name});
}

final List<JobTenure> dummyJobTenure = [
  JobTenure(id: '1', name: '1년 미만'),
  JobTenure(id: '2', name: '1~2년'),
  JobTenure(id: '3', name: '3~5년'),
  JobTenure(id: '4', name: '6년 이상'),
];
