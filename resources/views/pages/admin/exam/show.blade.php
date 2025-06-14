@extends('layouts.admin')

@section('title')
  Detail Bank Soal
@endsection

@section('content')
<div class="container">
    <!-- Notifikasi sukses -->
    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    <h1>Detail Bank Soal: {{ $exam->title }}</h1>
    
    <div class="card mb-3">
        <div class="card-body">
            <p><strong>Deskripsi:</strong> {!! $exam->description !!}</p>
            <p><strong>Tipe Ujian:</strong> {{ $exam->exam_type }}</p>
            <p><strong>Published:</strong> {{ $exam->is_published ? 'Ya' : 'Tidak' }}</p>
            <p><strong>Dibuat Oleh:</strong> {{ $exam->created_by }}</p>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <a href="{{ route('tryout.edit', $exam->id) }}" class="btn btn-secondary">Edit Bank Soal</a>
        </div>
        <div class="col-md-6 text-right">
            <form action="{{ route('tryout.destroy', $exam->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('Anda yakin ingin menghapus bank soal ini?');">
                @csrf
                @method('DELETE')
                <button class="btn btn-danger">Hapus Bank Soal</button>
            </form>
        </div>
    </div>

    <hr>

    <h3>Pertanyaan</h3>
    
    @if($exam->questions->count() > 0)
        <!-- Filter berdasarkan mata pelajaran -->
        <div class="row mb-3">
            <div class="col-md-4">
                <label for="subCategoryFilter">Filter berdasarkan Mata Pelajaran:</label>
                <select id="subCategoryFilter" class="form-control">
                    <option value="">Semua Mata Pelajaran</option>
                    @foreach($exam->questions->groupBy('subCategory.name') as $subCategoryName => $questions)
                        <option value="{{ $subCategoryName }}">{{ $subCategoryName }} ({{ $questions->count() }})</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-4">
                <label for="difficultyFilter">Filter berdasarkan Tingkat Kesulitan:</label>
                <select id="difficultyFilter" class="form-control">
                    <option value="">Semua Tingkat</option>
                    <option value="mudah">Mudah</option>
                    <option value="sedang">Sedang</option>
                    <option value="susah">Susah</option>
                </select>
            </div>
            <div class="col-md-4">
                <label for="statusFilter">Filter berdasarkan Status:</label>
                <select id="statusFilter" class="form-control">
                    <option value="">Semua Status</option>
                    <option value="ditinjau">Ditinjau</option>
                    <option value="diterima">Diterima</option>
                    <option value="ditolak">Ditolak</option>
                </select>
            </div>
        </div>

        <!-- Tabel pertanyaan -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered" id="questionsTable">
                <thead class="thead-dark">
                    <tr>
                        <th>No</th>
                        <th>Pertanyaan</th>
                        <th>Mata Pelajaran</th>
                        <th>Pembuat</th>
                        <th>Tingkat Kesulitan</th>
                        <th>Tipe Soal</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($exam->questions as $index => $question)
                        <tr class="question-row" 
                            data-subcategory="{{ $question->subCategory->name ?? '' }}"
                            data-difficulty="{{ strtolower($question->difficulty ?? '') }}"
                            data-status="{{ strtolower($question->status ?? 'ditinjau') }}">
                            <td>{{ $index + 1 }}</td>
                            <td>
                                <div class="question-text">
                                    {!! Str::limit(strip_tags($question->question_text), 80) !!}
                                </div>
                            </td>
                            <td>
                                <span class="badge badge-info">
                                    {{ $question->subCategory->name ?? 'Tidak Ditentukan' }}
                                </span>
                            </td>
                            <td>
                                <small>
                                    {{ $question->user->name ?? 'Unknown' }}
                                    <br>
                                    <em>{{ $question->created_at->format('d/m/Y') }}</em>
                                </small>
                            </td>
                            <td>
                                @if(strtolower($question->difficulty ?? '') == 'mudah')
                                    <span class="badge badge-success">Mudah</span>
                                @elseif(strtolower($question->difficulty ?? '') == 'sedang')
                                    <span class="badge badge-warning">Sedang</span>
                                @elseif(strtolower($question->difficulty ?? '') == 'susah')
                                    <span class="badge badge-danger">Susah</span>
                                @else
                                    <span class="badge badge-secondary">Tidak Ditentukan</span>
                                @endif
                            </td>
                            <td>
                                <span class="badge badge-primary">{{ ucfirst($question->question_type) }}</span>
                            </td>
                            <td>
                                @if(strtolower($question->status ?? 'ditinjau') == 'diterima')
                                    <span class="badge badge-success">Diterima</span>
                                @elseif(strtolower($question->status ?? 'ditinjau') == 'ditolak')
                                    <span class="badge badge-danger">Ditolak</span>
                                @elseif(strtolower($question->status ?? 'ditinjau') == 'ditinjau')
                                    <span class="badge badge-warning">Ditinjau</span>
                                @else
                                    <span class="badge badge-secondary">Tidak Diketahui</span>
                                @endif
                            </td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="{{ route('question.show', $question->id) }}" 
                                       class="btn btn-sm btn-info" 
                                       title="Detail">
                                        <i class="fas fa-eye"></i> Detail
                                    </a>
                                    <a href="{{ route('question.edit', $question->id) }}" 
                                       class="btn btn-sm btn-warning" 
                                       title="Edit">
                                        <i class="fas fa-edit"></i> Update
                                    </a>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <!-- Informasi total -->
        <div class="row mt-3">
            <div class="col-md-12">
                <p class="text-muted">
                    Total: <span id="totalQuestions">{{ $exam->questions->count() }}</span> pertanyaan
                    | Ditampilkan: <span id="visibleQuestions">{{ $exam->questions->count() }}</span> pertanyaan
                </p>
            </div>
        </div>
    @else
        <div class="alert alert-info">
            <p>Tidak ada pertanyaan. <a href="{{ route('question.create', ['exam_id' => $exam->id]) }}">Buat pertanyaan baru</a></p>
        </div>
    @endif
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const subCategoryFilter = document.getElementById('subCategoryFilter');
    const difficultyFilter = document.getElementById('difficultyFilter');
    const statusFilter = document.getElementById('statusFilter');
    const questionRows = document.querySelectorAll('.question-row');
    const visibleQuestionsSpan = document.getElementById('visibleQuestions');

    function filterQuestions() {
        const subCategoryValue = subCategoryFilter.value.toLowerCase();
        const difficultyValue = difficultyFilter.value.toLowerCase();
        const statusValue = statusFilter.value.toLowerCase();
        
        let visibleCount = 0;

        questionRows.forEach(row => {
            const rowSubCategory = row.dataset.subcategory.toLowerCase();
            const rowDifficulty = row.dataset.difficulty.toLowerCase();
            const rowStatus = row.dataset.status.toLowerCase();

            const matchSubCategory = !subCategoryValue || rowSubCategory.includes(subCategoryValue);
            const matchDifficulty = !difficultyValue || rowDifficulty === difficultyValue;
            const matchStatus = !statusValue || rowStatus === statusValue;

            if (matchSubCategory && matchDifficulty && matchStatus) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        visibleQuestionsSpan.textContent = visibleCount;
    }

    subCategoryFilter.addEventListener('change', filterQuestions);
    difficultyFilter.addEventListener('change', filterQuestions);
    statusFilter.addEventListener('change', filterQuestions);
});
</script>

<style>
.question-text {
    max-width: 300px;
    word-wrap: break-word;
}

.table th {
    vertical-align: middle;
    white-space: nowrap;
}

.table td {
    vertical-align: middle;
}

.btn-group .btn {
    margin-right: 2px;
}

.badge {
    font-size: 0.8em;
}
</style>
@endsection