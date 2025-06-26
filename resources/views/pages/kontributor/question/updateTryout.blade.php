@extends('layouts.admin')

@section('title')
    Edit Pertanyaan
@endsection

@section('content')
<div class="container">
    <!-- Notifikasi sukses -->
    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    <h1>Edit Pertanyaan</h1>

    @if($errors->any())
       <div class="alert alert-danger">
           <ul>
             @foreach($errors->all() as $error)
                <li>{{ $error }}</li>
             @endforeach
           </ul>
       </div>
    @endif

    <form action="{{ route('question.update', $question->id) }}" method="POST" enctype="multipart/form-data">
        @csrf
        @method('PUT')
        <!-- Hidden exam_id -->
        <input type="hidden" name="exam_id" value="{{ $question->exam_id }}">

       @php
function fixImageUrls($html) {
    return preg_replace_callback(
        '/src="([^"]+)"/i',
        function ($matches) {
            $url = $matches[1];
            if (preg_match('/^http(s)?:\/\//', $url)) {
                return 'src="' . $url . '"';
            } else {
                return 'src="' . asset($url) . '"';
            }
        },
        $html
    );
}

$questionTextFixed = old('question_text', isset($question->question_text) ? fixImageUrls($question->question_text) : '');
@endphp

<div class="form-group">
    <label for="question_text">Pertanyaan</label>
    <textarea name="question_text" id="question_text" class="form-control tiny-editor" readonly>{!! $questionTextFixed !!}</textarea>
</div>


        <div class="form-group">
            <label for="question_type">Tipe Soal</label>
            <select name="question_type" id="question_type" disabled class="form-control" onchange="changeQuestionType()" required>
                <option value="">-- Pilih Tipe Soal --</option>
                <option value="pilihan_ganda" {{ old('question_type', $question->question_type)=='pilihan_ganda' ? 'selected' : '' }}>Pilihan Ganda</option>
                <option value="pilihan_majemuk" {{ old('question_type', $question->question_type)=='pilihan_majemuk' ? 'selected' : '' }}>Pilihan Majemuk</option>
                <option value="isian" {{ old('question_type', $question->question_type)=='isian' ? 'selected' : '' }}>Isian</option>
            </select>
        </div>


        <div class="form-group">
            <label for="lesson">Pelajaran (Lesson)</label>
            <input type="text" name="lesson" id="lesson" class="form-control" readonly value="{{ old('lesson', $question->lesson) }}" required>
        </div>

        <div class="form-group">
            <label for="sub_category_id">Mata Pelajaran</label>
            <select name="sub_category_id" id="sub_category_id" disabled class="form-control" required>
                <option value="">-- Pilih Mata Pelajaran --</option>
                @foreach($sub_categories as $subCat)
                    <option value="{{ $subCat->id }}" {{ old('sub_category_id', $question->sub_category_id)==$subCat->id ? 'selected' : '' }}>
                        {{ $subCat->name }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- <div class="form-group">
            <label for="difficulty">Tingkat Kesulitan</label>
            <select name="difficulty" id="difficulty" class="form-control" disabled required>
                <option value="Mudah"  {{ old('difficulty', $question->difficulty)=='Mudah'  ? 'selected':'' }}>Mudah</option>
                <option value="Sedang" {{ old('difficulty', $question->difficulty)=='Sedang' ? 'selected':'' }}>Sedang</option>
                <option value="Sulit"  {{ old('difficulty', $question->difficulty)=='Sulit'  ? 'selected':'' }}>Sulit</option>
            </select>
            @error('difficulty')
            <small class="text-danger">{{ $message }}</small>
            @enderror
        </div> --}}
@if(Auth::user()->roles === 'ADMIN')
        {{-- ADMIN hanya ubah status --}}
        <div class="form-group">
            <label for="status">Status Review</label>
            <select name="status" id="status" class="form-control" required>
                <option value="Ditinjau"  {{ old('status', $question->status)=='Ditinjau'  ? 'selected':'' }}>Ditinjau</option>
                <option value="Diterima"  {{ old('status', $question->status)=='Diterima'  ? 'selected':'' }}>Diterima</option>
                <option value="Ditolak"   {{ old('status', $question->status)=='Ditolak'   ? 'selected':'' }}>Ditolak</option>
            </select>
        </div>
@endif

        <button type="submit" class="btn btn-success">Simpan Perubahan</button>
    </form>
</div>
@endsection

@push('addon-script')

<!-- Konfigurasi MathJax -->
<script>
    window.MathJax = {
        tex: {
            inlineMath: [['$', '$'], ['\\(', '\\)']],
            displayMath: [['$$', '$$'], ['\\[', '\\]']]
        },
        svg: { fontCache: 'global' }
    };
</script>
<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        if (window.MathJax) {
            MathJax.typeset(); // Render semua rumus di halaman
        }
    });
</script>

{{-- tinyMCE --}}
{{-- <script src="https://cdn.tiny.cloud/1/p5gi92z4l60ecwn8741x16fryd8qwwwadeojxxh3t1s1uh40/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
tinymce.init({
  selector: '.tiny-editor',
  height: 300,
  plugins: 'image code',
  toolbar: 'undo redo | bold italic | alignleft aligncenter alignright | image | code',
  images_upload_url: '/upload-image',
  automatic_uploads: true,
  file_picker_types: 'image',
  file_picker_callback: function (cb, value, meta) {
    const input = document.createElement('input');
    input.setAttribute('type', 'file');
    input.setAttribute('accept', 'image/*');

    input.onchange = function () {
      const file = this.files[0];
      const formData = new FormData();
      formData.append('file', file);

      fetch('/upload-image', {
        method: 'POST',
        body: formData,
        headers: {
          'X-CSRF-TOKEN': '{{ csrf_token() }}'
        }
      })
      .then(response => response.json())
      .then(result => {
        cb(result.location);
      })
      .catch(error => {
        console.error('Upload error:', error);
      });
    };

    input.click();
  },
  content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }',
  setup: function (editor) {
    // Simpan daftar gambar saat ini di editor
    let currentImages = [];

    // Fungsi untuk mendapatkan semua src gambar dalam editor
    function getEditorImages() {
      const imgs = editor.getBody().querySelectorAll('img');
      return Array.from(imgs).map(img => img.getAttribute('src'));
    }

    // Saat editor diinisialisasi, simpan gambar awal
    editor.on('init', function () {
      currentImages = getEditorImages();
    });

    // Pada setiap perubahan konten, cek apakah ada gambar yang dihapus
    editor.on('NodeChange Change KeyUp', function () {
      const newImages = getEditorImages();

      // Cari gambar yang ada di currentImages tapi sudah hilang di newImages
      const deletedImages = currentImages.filter(src => !newImages.includes(src));

      // Update currentImages
      currentImages = newImages;

      // Kirim permintaan hapus ke backend untuk gambar yang dihapus
      deletedImages.forEach(src => {
        let imagePath = src;
        try {
          const url = new URL(src);
          // Asumsikan URL berbentuk .../storage/...
          // kita ekstrak path relatif setelah /storage/
          if (url.pathname.startsWith('/storage/')) {
            imagePath = url.pathname.replace('/storage/', '');
          }
        } catch (e) {
          // src bukan URL, gunakan langsung
        }

        fetch('/delete-image', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': '{{ csrf_token() }}',
          },
          body: JSON.stringify({ image_path: imagePath }),
        })
        .then(res => res.json())
        .then(data => {
          if (data.success) {
            console.log('Image deleted:', imagePath);
          } else {
            console.warn('Failed to delete image:', imagePath);
          }
        })
        .catch(console.error);
      });
    });

    // Opsional: support MathJax jika kamu pakai
    editor.on('Change KeyUp', function () {
      if (window.MathJax) {
        MathJax.typesetPromise([editor.getBody()]).catch(err => {
          console.error('MathJax typeset error:', err);
        });
      }
    });
  }
});
</script> --}}

<script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script>


<script>
    class MyUploadAdapter {
        constructor(loader) {
            this.loader = loader;
        }

        upload() {
            return this.loader.file
                .then(file => new Promise((resolve, reject) => {
                    const data = new FormData();
                    data.append('upload', file);

                    fetch('{{ route("ckeditor.upload") }}', {
                        method: 'POST',
                        headers: {
                            'X-CSRF-TOKEN': '{{ csrf_token() }}'
                        },
                        body: data
                    })
                    .then(response => response.json())
                    .then(result => {
                        resolve({
                            default: result.url
                        });
                    })
                    .catch(error => {
                        reject('Upload failed');
                    });
                }));
        }

        abort() {
            // Optional
        }
    }

    function MyCustomUploadAdapterPlugin(editor) {
        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
            return new MyUploadAdapter(loader);
        };
    }

     function getImageSrcs(html) {
        const doc = new DOMParser().parseFromString(html, 'text/html');
        return Array.from(doc.querySelectorAll('img')).map(img => img.getAttribute('src'));
    }

    // List ID textarea yang ingin kamu jadikan CKEditor
    const editorIds = ['question_text', 'explanation', 'option1', 'option2', 'option3', 'option4', 'option5'];

    // Menyimpan instance editor dan previousImages per textarea
    const editors = {};

    editorIds.forEach(id => {
        const textarea = document.querySelector(`#${id}`);
        if (!textarea) return; // skip kalau elemen tidak ditemukan

        ClassicEditor
            .create(textarea, {
                extraPlugins: [MyCustomUploadAdapterPlugin],
            })
            .then(editor => {
                console.log(`CKEditor ready on #${id}`);

                editors[id] = {
                    instance: editor,
                    previousImages: getImageSrcs(editor.getData())
                };

                editor.model.document.on('change:data', () => {
                    const currentImages = getImageSrcs(editor.getData());
                    const deletedImages = editors[id].previousImages.filter(src => !currentImages.includes(src));

                    deletedImages.forEach(src => {
                        fetch('{{ route("ckeditor.delete") }}', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                                'X-CSRF-TOKEN': '{{ csrf_token() }}'
                            },
                            body: JSON.stringify({ src })
                        })
                        .then(res => res.json())
                        .then(data => console.log('Deleted:', data))
                        .catch(err => console.error('Delete failed', err));
                    });

                    editors[id].previousImages = currentImages;
                });
            })
            .catch(error => {
                console.error(`CKEditor init error on #${id}:`, error);
            });
    });
</script>
<script>
    function changeQuestionType() {
        let type = document.getElementById("question_type").value;
        document.getElementById("section-pilihan_ganda").style.display = type === "pilihan_ganda" ? "block" : "none";
        document.getElementById("section-pilihan_majemuk").style.display = type === "pilihan_majemuk" ? "block" : "none";
        document.getElementById("section-isian").style.display = type === "isian" ? "block" : "none";
    }

    // Panggil saat halaman dimuat untuk menampilkan opsi yang sesuai dengan pilihan sebelumnya
    window.onload = function() {
        changeQuestionType();
    };
</script>
@endpush