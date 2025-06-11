@extends('layouts.app')

@section('title','Subtest Selesai')

@section('content')
<div class="container py-5 text-center">

  @if(isset($error))
    <div class="alert alert-danger">
      {{ $error }}
    </div>
  @endif

  @if(!isset($error))
    <h3>Anda menyelesaikan subtest “{{ $subCategory->name }}”</h3>

    @if($next)
      <a href="{{ route('tryout-subtest', ['exam'=>$exam->slug,'subtest'=>$next->id]) }}"
         class="btn btn-primary mt-4">
        Lanjut ke “{{ $next->name }}”
      </a>
    @else
      <a href="{{ route('tryout')}}" class="btn btn-success mt-4">
        Kembali Ke daftar Tryout
      </a>
    @endif
  @endif

</div>
@endsection
