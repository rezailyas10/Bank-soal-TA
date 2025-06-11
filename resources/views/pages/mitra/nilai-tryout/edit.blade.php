@extends('layouts.mitra')

@section('title')
  Update Bank Soal
@endsection

@section('content')
<div class="col-md-12">

  <!-- Notifikasi sukses -->
     @if(session('success'))
     <div class="alert alert-success">
         {{ session('success') }}
     </div>
 @endif
    @if ($errors->any())
        <div class="alert alert-danger">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif
    <div class="container">
        <h1>Update Tryout</h1>

        <form action="{{ route('tryout.update', $exam->id) }}" method="POST">
            @csrf
            @method('PUT')

            <div class="form-group">
                <label for="title">Nama Tryout</label>
                <input type="text" name="title" id="title" class="form-control" value="{{ old('title', $exam->title) }}" required>
            </div>

            <div class="form-group">
                <label for="description">Deskripsi</label>
                <textarea name="description" id="description" rows="3" class="form-control" >{{ old('description', $exam->description) }}</textarea>
            </div>
            
             <input type="hidden" name="exam_type" id="exam_type" value="tryout">

            {{-- <div class="form-group" id="practice-section">
                <label for="sub_category_id">Mata Pelajaran</label>
                <select name="sub_category_id" id="sub_category_id" class="form-control">
                    <option value="">-- Pilih Sub Category --</option>
                    @foreach($sub_categories as $subCategory)
                        <option value="{{ $subCategory->id }}" {{ old('sub_category_id', $exam->sub_category_id) == $subCategory->id ? 'selected' : '' }}>
                            {{ $subCategory->name }}
                        </option>
                    @endforeach
                </select>
            </div> --}}

            
         
            {{-- === SECTION: tryout --}}
            <div id="tryout-section" >
                <label class="d-block">Daftar Subtest</label>
                <div id="subtest-list">
                    @if(isset($tryoutSubtests) && $tryoutSubtests->count() > 0)
                        @foreach($tryoutSubtests as $subtest)
                        <div class="d-flex mb-2 subtest-item">
                            <!-- nilai lama -->
                            <input type="hidden"
                                name="old_subcategory_id[]"
                                value="{{ $subtest->subcategory_id }}">

                            <!-- select nilai baru -->
                            <select name="subcategory_id[]" class="form-control mr-2">
                            <option value="">-- Subtest --</option>
                            @foreach($sub_categories as $sub)
                                <option value="{{ $sub->id }}"
                                {{ $subtest->subcategory_id == $sub->id ? 'selected' : '' }}>
                                {{ $sub->name }}
                                </option>
                            @endforeach
                            </select>
                            <input type="number"
                                name="timer[]"
                                class="form-control mr-2"
                                placeholder="Timer (menit)"
                                value="{{ $subtest->timer }}">
                            <button type="button"
                                    class="btn btn-danger remove-row">-</button>
                        </div>
                        @endforeach
                    @else
                        <div class="d-flex mb-2 subtest-item">
                            <select name="subcategory_id[]" class="form-control mr-2">
                                <option value="">-- Subtest --</option>
                                @foreach($sub_categories as $sub)
                                    <option value="{{ $sub->id }}">{{ $sub->name }}</option>
                                @endforeach
                            </select>
                            <input type="number"
                                name="timer[]"
                                class="form-control mr-2"
                                placeholder="Timer (menit)">
                            <button type="button"
                                    class="btn btn-danger remove-row">-</button>
                        </div>
                    @endif
                </div>
                <button type="button"
                        id="add-row"
                        class="btn btn-primary btn-sm mb-3">
                    + Tambah Subtest
                </button>

                {{-- tanggal dibuka/ditutup masuk exam --}}
                <div class="form-group">
                    <label for="tanggal_dibuka">Tanggal Dibuka</label>
                    <input
                      type="date"
                      name="tanggal_dibuka"
                      id="tanggal_dibuka"
                      class="form-control"
                       value="{{ old('tanggal_dibuka', optional($exam->tanggal_dibuka)->format('Y-m-d')) }}"
                    >
                  </div>
                  
                  <div class="form-group">
                    <label for="tanggal_ditutup">Tanggal Ditutup</label>
                    <input
                      type="date"
                      name="tanggal_ditutup"
                      id="tanggal_ditutup"
                      class="form-control"
                       value="{{ old('tanggal_ditutup', optional($exam->tanggal_ditutup)->format('Y-m-d')) }}"
                    >
                  </div>
            </div>

            <div class="form-group">
                <label for="is_published">Published</label>
                <select name="is_published" id="is_published" class="form-control">
                    <option value="0" {{ old('is_published', $exam->is_published) == 0 ? 'selected' : '' }}>Tidak</option>
                    <option value="1" {{ old('is_published', $exam->is_published) == 1 ? 'selected' : '' }}>Ya</option>
                </select>
            </div>

            <!-- Data user otomatis, diset melalui input hidden -->
            <input type="hidden" name="created_by" value="{{ auth()->user()->name }}">
            <div class="form-group">
                <label for="user_name">Nama User</label>
                <input type="text" id="user_name" class="form-control" value="{{ auth()->user()->name }}" disabled>
            </div>

            <button type="submit" class="btn btn-success">Update</button>
        </form>
    </div>
</div>
@endsection

@push('addon-script')
<script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script>
<script>
    ClassicEditor
        .create(document.querySelector('#description'))
        .then(editor => {
            console.log(editor);
        })
        .catch(error => {
            console.error(error);
        });
</script>

<script>
    // const typeEl   = document.getElementById('exam_type');
    // const pracSec  = document.getElementById('practice-section');
    // const tryoutSec= document.getElementById('tryout-section');
  
    // function toggleSections() {
    //   if (typeEl.value === 'tryout') {
    //     pracSec.style.display   = 'none';
    //     tryoutSec.style.display = 'block';
    //   } else {
    //     pracSec.style.display   = 'block';
    //     tryoutSec.style.display = 'none';
    //   }
    // }
  
    document.getElementById('add-row').addEventListener('click', () => {
  const list = document.getElementById('subtest-list');
  const item = list.querySelector('.subtest-item').cloneNode(true);
  // reset values
  item.querySelector('select').value = '';
  item.querySelector('input').value = '';
  list.appendChild(item);
  attachRemove(item);
});

function attachRemove(row) {
  row.querySelector('.remove-row').addEventListener('click', () => {
    const all = document.querySelectorAll('.subtest-item');
    if (all.length > 1) {
      const oldInput = row.querySelector('input[name="old_subcategory_id[]"]');
      if (oldInput && oldInput.value) {
        // jika input hidden ada dan memiliki value
        let deletedEl = document.getElementById('deleted_old');
        if (!deletedEl) {
          deletedEl = document.createElement('input');
          deletedEl.type = 'hidden';
          deletedEl.name = 'deleted_old[]';
          deletedEl.id = 'deleted_old';
          deletedEl.value = '';
          document.querySelector('form').appendChild(deletedEl);
        }

        const arr = deletedEl.value ? deletedEl.value.split(',') : [];
        arr.push(oldInput.value);
        deletedEl.value = arr.join(',');
      }

      row.remove();
    }
  });
}

// attach to ALL initial rows, not just the first one
document.querySelectorAll('.subtest-item').forEach(item => {
  attachRemove(item);
});
  </script>

@endpush
