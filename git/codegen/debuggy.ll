; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%a = type { i64, %a* }

@longn = constant [5 x i8] c"%ld \00"

; Function Attrs: inaccessiblememonly nofree nounwind willreturn mustprogress
declare noalias noundef i8* @malloc(i64 noundef) local_unnamed_addr #0

; Function Attrs: nofree nounwind
declare noundef i64 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
define %a* @init(<5 x i64> %0, i64 %1) local_unnamed_addr #1 !dbg !3 {
  %3 = icmp sgt i64 %1, 0, !dbg !7
  br i1 %3, label %.lr.ph, label %._crit_edge, !dbg !9

.lr.ph:                                           ; preds = %2, %.lr.ph
  %4 = phi %a* [ %9, %.lr.ph ], [ null, %2 ]
  %5 = phi i64 [ %14, %.lr.ph ], [ 0, %2 ]
  %6 = xor i64 %5, -1, !dbg !10
  %7 = add i64 %6, %1, !dbg !10
  %8 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16), !dbg !11
  %9 = bitcast i8* %8 to %a*, !dbg !12
  %10 = extractelement <5 x i64> %0, i64 %7, !dbg !13
  %11 = bitcast i8* %8 to i64*, !dbg !14
  store i64 %10, i64* %11, align 4, !dbg !15
  %12 = getelementptr i8, i8* %8, i64 8, !dbg !16
  %13 = bitcast i8* %12 to %a**, !dbg !17
  store %a* %4, %a** %13, align 8, !dbg !18
  %14 = add nuw nsw i64 %5, 1, !dbg !19
  %exitcond.not = icmp eq i64 %14, %1, !dbg !7
  br i1 %exitcond.not, label %._crit_edge.loopexit, label %.lr.ph, !dbg !9

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %15 = bitcast i8* %8 to %a*, !dbg !12
  br label %._crit_edge, !dbg !20

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.lcssa = phi %a* [ null, %2 ], [ %15, %._crit_edge.loopexit ]
  ret %a* %.lcssa, !dbg !20
}

; Function Attrs: nofree nounwind willreturn mustprogress
define noalias %a* @cons(i64 %0, %a* %1) local_unnamed_addr #2 !dbg !21 {
  %3 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16), !dbg !22
  %4 = bitcast i8* %3 to %a*, !dbg !24
  %5 = bitcast i8* %3 to i64*, !dbg !25
  store i64 %0, i64* %5, align 4, !dbg !26
  %6 = getelementptr i8, i8* %3, i64 8, !dbg !27
  %7 = bitcast i8* %6 to %a**, !dbg !28
  store %a* %1, %a** %7, align 8, !dbg !29
  ret %a* %4, !dbg !30
}

; Function Attrs: nofree nounwind
define i64 @printli(%a* readonly %0) local_unnamed_addr #1 !dbg !31 {
  %.not7 = icmp eq %a* %0, null, !dbg !32
  br i1 %.not7, label %._crit_edge, label %.lr.ph, !dbg !34

.lr.ph:                                           ; preds = %1, %.lr.ph
  %2 = phi %a* [ %.unpack6, %.lr.ph ], [ %0, %1 ]
  %.elt = getelementptr inbounds %a, %a* %2, i64 0, i32 0, !dbg !35
  %.unpack = load i64, i64* %.elt, align 8, !dbg !35
  %3 = tail call i64 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @longn, i64 0, i64 0), i64 %.unpack), !dbg !36
  %.elt5 = getelementptr inbounds %a, %a* %2, i64 0, i32 1, !dbg !37
  %.unpack6 = load %a*, %a** %.elt5, align 8, !dbg !37
  %.not = icmp eq %a* %.unpack6, null, !dbg !32
  br i1 %.not, label %._crit_edge, label %.lr.ph, !dbg !34

._crit_edge:                                      ; preds = %.lr.ph, %1
  %4 = tail call i32 @putchar(i32 10), !dbg !38
  ret i64 1, !dbg !39
}

; Function Attrs: nofree norecurse nosync nounwind readonly willreturn mustprogress
define %a* @queue(%a* nocapture readonly %0) local_unnamed_addr #3 !dbg !40 {
  %2 = getelementptr %a, %a* %0, i64 0, i32 1, !dbg !41
  %3 = load %a*, %a** %2, align 8, !dbg !43
  ret %a* %3, !dbg !44
}

; Function Attrs: nofree norecurse nosync nounwind readonly willreturn mustprogress
define i64 @tete(%a* nocapture readonly %0) local_unnamed_addr #3 !dbg !45 {
  %2 = getelementptr %a, %a* %0, i64 0, i32 0, !dbg !46
  %3 = load i64, i64* %2, align 4, !dbg !48
  ret i64 %3, !dbg !49
}

; Function Attrs: nofree norecurse nosync nounwind readnone willreturn mustprogress
define i1 @estvide(%a* readnone %0) local_unnamed_addr #4 !dbg !50 {
  %2 = icmp eq %a* %0, null, !dbg !51
  ret i1 %2, !dbg !53
}

; Function Attrs: nofree nounwind
define %a* @conc(%a* readonly %0, %a* %1) local_unnamed_addr #1 !dbg !54 {
  %3 = icmp eq %a* %0, null, !dbg !55
  br i1 %3, label %15, label %4, !dbg !58

4:                                                ; preds = %2
  %5 = getelementptr %a, %a* %0, i64 0, i32 0, !dbg !59
  %6 = load i64, i64* %5, align 4, !dbg !61
  %7 = getelementptr %a, %a* %0, i64 0, i32 1, !dbg !62
  %8 = load %a*, %a** %7, align 8, !dbg !64
  %9 = tail call %a* @conc(%a* %8, %a* %1), !dbg !65
  %10 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !66
  %11 = bitcast i8* %10 to %a*, !dbg !68
  %12 = bitcast i8* %10 to i64*, !dbg !69
  store i64 %6, i64* %12, align 4, !dbg !70
  %13 = getelementptr i8, i8* %10, i64 8, !dbg !71
  %14 = bitcast i8* %13 to %a**, !dbg !72
  store %a* %9, %a** %14, align 8, !dbg !73
  ret %a* %11, !dbg !74

15:                                               ; preds = %2
  ret %a* %1, !dbg !74
}

; Function Attrs: nofree nounwind
define noalias %a* @conchy(%a* readonly %0, %a* %1) local_unnamed_addr #1 !dbg !75 {
  %3 = icmp eq %a* %0, null, !dbg !76
  br i1 %3, label %15, label %4, !dbg !79

4:                                                ; preds = %2
  %5 = getelementptr %a, %a* %0, i64 0, i32 0, !dbg !80
  %6 = load i64, i64* %5, align 4, !dbg !82
  %7 = getelementptr %a, %a* %0, i64 0, i32 1, !dbg !83
  %8 = load %a*, %a** %7, align 8, !dbg !85
  %9 = tail call %a* @conchy(%a* %8, %a* %1), !dbg !86
  %10 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !87
  %11 = bitcast i8* %10 to %a*, !dbg !89
  %12 = bitcast i8* %10 to i64*, !dbg !90
  store i64 %6, i64* %12, align 4, !dbg !91
  %13 = getelementptr i8, i8* %10, i64 8, !dbg !92
  %14 = bitcast i8* %13 to %a**, !dbg !93
  store %a* %9, %a** %14, align 8, !dbg !94
  br label %15, !dbg !95

15:                                               ; preds = %4, %2
  %16 = phi %a* [ %11, %4 ], [ %1, %2 ]
  %17 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !96
  %18 = bitcast i8* %17 to %a*, !dbg !98
  %19 = bitcast i8* %17 to i64*, !dbg !99
  store i64 9, i64* %19, align 4, !dbg !100
  %20 = getelementptr i8, i8* %17, i64 8, !dbg !101
  %21 = bitcast i8* %20 to %a**, !dbg !102
  store %a* %16, %a** %21, align 8, !dbg !103
  ret %a* %18, !dbg !104
}

; Function Attrs: nofree nounwind
define void @main() local_unnamed_addr #1 !dbg !105 {
.lr.ph.i:
  %0 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !106
  %1 = bitcast i8* %0 to i64*, !dbg !109
  store i64 7, i64* %1, align 4, !dbg !110
  %2 = getelementptr i8, i8* %0, i64 8, !dbg !111
  %3 = bitcast i8* %2 to %a**, !dbg !112
  store %a* null, %a** %3, align 8, !dbg !113
  %4 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !114
  %5 = bitcast i8* %4 to i64*, !dbg !116
  store i64 14, i64* %5, align 4, !dbg !117
  %6 = getelementptr i8, i8* %4, i64 8, !dbg !118
  %7 = bitcast i8* %6 to %a**, !dbg !119
  store %a* null, %a** %7, align 8, !dbg !120
  %8 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !114
  %9 = bitcast i8* %8 to i64*, !dbg !116
  store i64 13, i64* %9, align 4, !dbg !117
  %10 = getelementptr i8, i8* %8, i64 8, !dbg !118
  %11 = bitcast i8* %10 to i8**, !dbg !120
  store i8* %4, i8** %11, align 8, !dbg !120
  %12 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !114
  %13 = bitcast i8* %12 to i64*, !dbg !116
  store i64 12, i64* %13, align 4, !dbg !117
  %14 = getelementptr i8, i8* %12, i64 8, !dbg !118
  %15 = bitcast i8* %14 to i8**, !dbg !120
  store i8* %8, i8** %15, align 8, !dbg !120
  %16 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !114
  %17 = bitcast i8* %16 to i64*, !dbg !116
  store i64 11, i64* %17, align 4, !dbg !117
  %18 = getelementptr i8, i8* %16, i64 8, !dbg !118
  %19 = bitcast i8* %18 to i8**, !dbg !120
  store i8* %12, i8** %19, align 8, !dbg !120
  %20 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !114
  %21 = bitcast i8* %20 to i64*, !dbg !116
  store i64 10, i64* %21, align 4, !dbg !117
  %22 = getelementptr i8, i8* %20, i64 8, !dbg !118
  %23 = bitcast i8* %22 to i8**, !dbg !120
  store i8* %16, i8** %23, align 8, !dbg !120
  %24 = bitcast i8* %0 to %a*, !dbg !121
  %25 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !122
  %26 = bitcast i8* %25 to i64*, !dbg !124
  store i64 14, i64* %26, align 4, !dbg !125
  %27 = getelementptr i8, i8* %25, i64 8, !dbg !126
  %28 = bitcast i8* %27 to %a**, !dbg !127
  store %a* null, %a** %28, align 8, !dbg !128
  %29 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !122
  %30 = bitcast i8* %29 to i64*, !dbg !124
  store i64 13, i64* %30, align 4, !dbg !125
  %31 = getelementptr i8, i8* %29, i64 8, !dbg !126
  %32 = bitcast i8* %31 to i8**, !dbg !128
  store i8* %25, i8** %32, align 8, !dbg !128
  %33 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !122
  %34 = bitcast i8* %33 to i64*, !dbg !124
  store i64 12, i64* %34, align 4, !dbg !125
  %35 = getelementptr i8, i8* %33, i64 8, !dbg !126
  %36 = bitcast i8* %35 to i8**, !dbg !128
  store i8* %29, i8** %36, align 8, !dbg !128
  %37 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !122
  %38 = bitcast i8* %37 to i64*, !dbg !124
  store i64 11, i64* %38, align 4, !dbg !125
  %39 = getelementptr i8, i8* %37, i64 8, !dbg !126
  %40 = bitcast i8* %39 to i8**, !dbg !128
  store i8* %33, i8** %40, align 8, !dbg !128
  %41 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !122
  %42 = bitcast i8* %41 to i64*, !dbg !124
  store i64 15, i64* %42, align 4, !dbg !125
  %43 = getelementptr i8, i8* %41, i64 8, !dbg !126
  %44 = bitcast i8* %43 to i8**, !dbg !128
  store i8* %37, i8** %44, align 8, !dbg !128
  %45 = bitcast i8* %20 to %a*, !dbg !129
  %46 = bitcast i8* %41 to %a*, !dbg !130
  %47 = tail call %a* @conc(%a* %45, %a* nonnull %46), !dbg !131
  %48 = tail call %a* @conc(%a* %24, %a* %47), !dbg !132
  %.not7.i = icmp eq %a* %48, null, !dbg !133
  br i1 %.not7.i, label %printli.exit.thread, label %.lr.ph.i4, !dbg !135

printli.exit.thread:                              ; preds = %.lr.ph.i
  %49 = tail call i32 @putchar(i32 10) #5, !dbg !136
  br label %.thread, !dbg !137

.lr.ph.i4:                                        ; preds = %.lr.ph.i, %.lr.ph.i4
  %50 = phi %a* [ %.unpack6.i, %.lr.ph.i4 ], [ %48, %.lr.ph.i ]
  %.elt.i = getelementptr inbounds %a, %a* %50, i64 0, i32 0, !dbg !138
  %.unpack.i = load i64, i64* %.elt.i, align 8, !dbg !138
  %51 = tail call i64 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @longn, i64 0, i64 0), i64 %.unpack.i) #5, !dbg !139
  %.elt5.i = getelementptr inbounds %a, %a* %50, i64 0, i32 1, !dbg !140
  %.unpack6.i = load %a*, %a** %.elt5.i, align 8, !dbg !140
  %.not.i = icmp eq %a* %.unpack6.i, null, !dbg !133
  br i1 %.not.i, label %printli.exit, label %.lr.ph.i4, !dbg !135

printli.exit:                                     ; preds = %.lr.ph.i4
  %52 = tail call i32 @putchar(i32 10) #5, !dbg !136
  %53 = icmp eq i8* %20, null, !dbg !141
  br i1 %53, label %64, label %.thread, !dbg !137

.thread:                                          ; preds = %printli.exit, %printli.exit.thread
  %54 = getelementptr %a, %a* %45, i64 0, i32 0, !dbg !143
  %55 = load i64, i64* %54, align 4, !dbg !145
  %56 = getelementptr %a, %a* %45, i64 0, i32 1, !dbg !146
  %57 = load %a*, %a** %56, align 8, !dbg !148
  %58 = tail call %a* @conc(%a* %57, %a* %46), !dbg !149
  %59 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !150
  %60 = bitcast i8* %59 to %a*, !dbg !152
  %61 = bitcast i8* %59 to i64*, !dbg !153
  store i64 %55, i64* %61, align 4, !dbg !154
  %62 = getelementptr i8, i8* %59, i64 8, !dbg !155
  %63 = bitcast i8* %62 to %a**, !dbg !156
  store %a* %58, %a** %63, align 8, !dbg !157
  br label %.lr.ph.i19.preheader, !dbg !158

64:                                               ; preds = %printli.exit
  %.not7.i13 = icmp eq i8* %41, null, !dbg !160
  br i1 %.not7.i13, label %printli.exit20, label %.lr.ph.i19.preheader, !dbg !158

.lr.ph.i19.preheader:                             ; preds = %.thread, %64
  %.ph37 = phi %a* [ %46, %64 ], [ %60, %.thread ]
  br label %.lr.ph.i19, !dbg !158

.lr.ph.i19:                                       ; preds = %.lr.ph.i19.preheader, %.lr.ph.i19
  %65 = phi %a* [ %.unpack6.i17, %.lr.ph.i19 ], [ %.ph37, %.lr.ph.i19.preheader ]
  %.elt.i14 = getelementptr inbounds %a, %a* %65, i64 0, i32 0, !dbg !161
  %.unpack.i15 = load i64, i64* %.elt.i14, align 8, !dbg !161
  %66 = tail call i64 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @longn, i64 0, i64 0), i64 %.unpack.i15) #5, !dbg !162
  %.elt5.i16 = getelementptr inbounds %a, %a* %65, i64 0, i32 1, !dbg !163
  %.unpack6.i17 = load %a*, %a** %.elt5.i16, align 8, !dbg !163
  %.not.i18 = icmp eq %a* %.unpack6.i17, null, !dbg !160
  br i1 %.not.i18, label %printli.exit20, label %.lr.ph.i19, !dbg !158

printli.exit20:                                   ; preds = %.lr.ph.i19, %64
  %67 = tail call i32 @putchar(i32 10) #5, !dbg !164
  %68 = icmp eq i8* %41, null, !dbg !165
  br i1 %68, label %79, label %.thread35, !dbg !167

.thread35:                                        ; preds = %printli.exit20
  %69 = getelementptr %a, %a* %46, i64 0, i32 0, !dbg !168
  %70 = load i64, i64* %69, align 4, !dbg !170
  %71 = getelementptr %a, %a* %46, i64 0, i32 1, !dbg !171
  %72 = load %a*, %a** %71, align 8, !dbg !173
  %73 = tail call %a* @conc(%a* %72, %a* %45), !dbg !174
  %74 = tail call dereferenceable_or_null(16) i8* @malloc(i64 16) #5, !dbg !175
  %75 = bitcast i8* %74 to %a*, !dbg !177
  %76 = bitcast i8* %74 to i64*, !dbg !178
  store i64 %70, i64* %76, align 4, !dbg !179
  %77 = getelementptr i8, i8* %74, i64 8, !dbg !180
  %78 = bitcast i8* %77 to %a**, !dbg !181
  store %a* %73, %a** %78, align 8, !dbg !182
  br label %.lr.ph.i27.preheader, !dbg !183

79:                                               ; preds = %printli.exit20
  %.not7.i21 = icmp eq i8* %20, null, !dbg !185
  br i1 %.not7.i21, label %printli.exit28, label %.lr.ph.i27.preheader, !dbg !183

.lr.ph.i27.preheader:                             ; preds = %.thread35, %79
  %.ph = phi %a* [ %45, %79 ], [ %75, %.thread35 ]
  br label %.lr.ph.i27, !dbg !183

.lr.ph.i27:                                       ; preds = %.lr.ph.i27.preheader, %.lr.ph.i27
  %80 = phi %a* [ %.unpack6.i25, %.lr.ph.i27 ], [ %.ph, %.lr.ph.i27.preheader ]
  %.elt.i22 = getelementptr inbounds %a, %a* %80, i64 0, i32 0, !dbg !186
  %.unpack.i23 = load i64, i64* %.elt.i22, align 8, !dbg !186
  %81 = tail call i64 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @longn, i64 0, i64 0), i64 %.unpack.i23) #5, !dbg !187
  %.elt5.i24 = getelementptr inbounds %a, %a* %80, i64 0, i32 1, !dbg !188
  %.unpack6.i25 = load %a*, %a** %.elt5.i24, align 8, !dbg !188
  %.not.i26 = icmp eq %a* %.unpack6.i25, null, !dbg !185
  br i1 %.not.i26, label %printli.exit28, label %.lr.ph.i27, !dbg !183

printli.exit28:                                   ; preds = %.lr.ph.i27, %79
  %82 = tail call i32 @putchar(i32 10) #5, !dbg !189
  %83 = tail call %a* @conchy(%a* %45, %a* %46), !dbg !190
  %.not7.i5 = icmp eq %a* %83, null, !dbg !191
  br i1 %.not7.i5, label %printli.exit12, label %.lr.ph.i11, !dbg !193

.lr.ph.i11:                                       ; preds = %printli.exit28, %.lr.ph.i11
  %84 = phi %a* [ %.unpack6.i9, %.lr.ph.i11 ], [ %83, %printli.exit28 ]
  %.elt.i6 = getelementptr inbounds %a, %a* %84, i64 0, i32 0, !dbg !194
  %.unpack.i7 = load i64, i64* %.elt.i6, align 8, !dbg !194
  %85 = tail call i64 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @longn, i64 0, i64 0), i64 %.unpack.i7) #5, !dbg !195
  %.elt5.i8 = getelementptr inbounds %a, %a* %84, i64 0, i32 1, !dbg !196
  %.unpack6.i9 = load %a*, %a** %.elt5.i8, align 8, !dbg !196
  %.not.i10 = icmp eq %a* %.unpack6.i9, null, !dbg !191
  br i1 %.not.i10, label %printli.exit12, label %.lr.ph.i11, !dbg !193

printli.exit12:                                   ; preds = %.lr.ph.i11, %printli.exit28
  %86 = tail call i32 @putchar(i32 10) #5, !dbg !197
  ret void, !dbg !198
}

attributes #0 = { inaccessiblememonly nofree nounwind willreturn mustprogress }
attributes #1 = { nofree nounwind }
attributes #2 = { nofree nounwind willreturn mustprogress }
attributes #3 = { nofree norecurse nosync nounwind readonly willreturn mustprogress }
attributes #4 = { nofree norecurse nosync nounwind readnone willreturn mustprogress }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "init", linkageName: "init", scope: null, file: !4, line: 7, type: !5, scopeLine: 7, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "./codegen/nimpass.mlir", directory: "/home/hugo/.local/bin/git")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 16, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 17, column: 5, scope: !8)
!10 = !DILocation(line: 20, column: 11, scope: !8)
!11 = !DILocation(line: 21, column: 11, scope: !8)
!12 = !DILocation(line: 22, column: 11, scope: !8)
!13 = !DILocation(line: 23, column: 11, scope: !8)
!14 = !DILocation(line: 24, column: 11, scope: !8)
!15 = !DILocation(line: 25, column: 5, scope: !8)
!16 = !DILocation(line: 26, column: 11, scope: !8)
!17 = !DILocation(line: 27, column: 11, scope: !8)
!18 = !DILocation(line: 28, column: 5, scope: !8)
!19 = !DILocation(line: 29, column: 11, scope: !8)
!20 = !DILocation(line: 32, column: 5, scope: !8)
!21 = distinct !DISubprogram(name: "cons", linkageName: "cons", scope: null, file: !4, line: 34, type: !5, scopeLine: 34, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!22 = !DILocation(line: 37, column: 10, scope: !23)
!23 = !DILexicalBlockFile(scope: !21, file: !4, discriminator: 0)
!24 = !DILocation(line: 38, column: 10, scope: !23)
!25 = !DILocation(line: 39, column: 10, scope: !23)
!26 = !DILocation(line: 40, column: 5, scope: !23)
!27 = !DILocation(line: 41, column: 10, scope: !23)
!28 = !DILocation(line: 42, column: 10, scope: !23)
!29 = !DILocation(line: 43, column: 5, scope: !23)
!30 = !DILocation(line: 44, column: 5, scope: !23)
!31 = distinct !DISubprogram(name: "printli", linkageName: "printli", scope: null, file: !4, line: 46, type: !5, scopeLine: 46, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!32 = !DILocation(line: 52, column: 10, scope: !33)
!33 = !DILexicalBlockFile(scope: !31, file: !4, discriminator: 0)
!34 = !DILocation(line: 53, column: 5, scope: !33)
!35 = !DILocation(line: 55, column: 10, scope: !33)
!36 = !DILocation(line: 59, column: 11, scope: !33)
!37 = !DILocation(line: 60, column: 11, scope: !33)
!38 = !DILocation(line: 65, column: 11, scope: !33)
!39 = !DILocation(line: 66, column: 5, scope: !33)
!40 = distinct !DISubprogram(name: "queue", linkageName: "queue", scope: null, file: !4, line: 68, type: !5, scopeLine: 68, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!41 = !DILocation(line: 71, column: 10, scope: !42)
!42 = !DILexicalBlockFile(scope: !40, file: !4, discriminator: 0)
!43 = !DILocation(line: 72, column: 10, scope: !42)
!44 = !DILocation(line: 73, column: 5, scope: !42)
!45 = distinct !DISubprogram(name: "tete", linkageName: "tete", scope: null, file: !4, line: 75, type: !5, scopeLine: 75, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!46 = !DILocation(line: 78, column: 10, scope: !47)
!47 = !DILexicalBlockFile(scope: !45, file: !4, discriminator: 0)
!48 = !DILocation(line: 79, column: 10, scope: !47)
!49 = !DILocation(line: 80, column: 5, scope: !47)
!50 = distinct !DISubprogram(name: "estvide", linkageName: "estvide", scope: null, file: !4, line: 82, type: !5, scopeLine: 82, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!51 = !DILocation(line: 84, column: 10, scope: !52)
!52 = !DILexicalBlockFile(scope: !50, file: !4, discriminator: 0)
!53 = !DILocation(line: 85, column: 5, scope: !52)
!54 = distinct !DISubprogram(name: "conc", linkageName: "conc", scope: null, file: !4, line: 87, type: !5, scopeLine: 87, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!55 = !DILocation(line: 84, column: 10, scope: !52, inlinedAt: !56)
!56 = distinct !DILocation(line: 88, column: 10, scope: !57)
!57 = !DILexicalBlockFile(scope: !54, file: !4, discriminator: 0)
!58 = !DILocation(line: 89, column: 5, scope: !57)
!59 = !DILocation(line: 78, column: 10, scope: !47, inlinedAt: !60)
!60 = distinct !DILocation(line: 93, column: 10, scope: !57)
!61 = !DILocation(line: 79, column: 10, scope: !47, inlinedAt: !60)
!62 = !DILocation(line: 71, column: 10, scope: !42, inlinedAt: !63)
!63 = distinct !DILocation(line: 94, column: 10, scope: !57)
!64 = !DILocation(line: 72, column: 10, scope: !42, inlinedAt: !63)
!65 = !DILocation(line: 95, column: 10, scope: !57)
!66 = !DILocation(line: 37, column: 10, scope: !23, inlinedAt: !67)
!67 = distinct !DILocation(line: 96, column: 10, scope: !57)
!68 = !DILocation(line: 38, column: 10, scope: !23, inlinedAt: !67)
!69 = !DILocation(line: 39, column: 10, scope: !23, inlinedAt: !67)
!70 = !DILocation(line: 40, column: 5, scope: !23, inlinedAt: !67)
!71 = !DILocation(line: 41, column: 10, scope: !23, inlinedAt: !67)
!72 = !DILocation(line: 42, column: 10, scope: !23, inlinedAt: !67)
!73 = !DILocation(line: 43, column: 5, scope: !23, inlinedAt: !67)
!74 = !DILocation(line: 101, column: 5, scope: !57)
!75 = distinct !DISubprogram(name: "conchy", linkageName: "conchy", scope: null, file: !4, line: 103, type: !5, scopeLine: 103, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!76 = !DILocation(line: 84, column: 10, scope: !52, inlinedAt: !77)
!77 = distinct !DILocation(line: 107, column: 10, scope: !78)
!78 = !DILexicalBlockFile(scope: !75, file: !4, discriminator: 0)
!79 = !DILocation(line: 108, column: 5, scope: !78)
!80 = !DILocation(line: 78, column: 10, scope: !47, inlinedAt: !81)
!81 = distinct !DILocation(line: 112, column: 10, scope: !78)
!82 = !DILocation(line: 79, column: 10, scope: !47, inlinedAt: !81)
!83 = !DILocation(line: 71, column: 10, scope: !42, inlinedAt: !84)
!84 = distinct !DILocation(line: 113, column: 10, scope: !78)
!85 = !DILocation(line: 72, column: 10, scope: !42, inlinedAt: !84)
!86 = !DILocation(line: 114, column: 10, scope: !78)
!87 = !DILocation(line: 37, column: 10, scope: !23, inlinedAt: !88)
!88 = distinct !DILocation(line: 115, column: 10, scope: !78)
!89 = !DILocation(line: 38, column: 10, scope: !23, inlinedAt: !88)
!90 = !DILocation(line: 39, column: 10, scope: !23, inlinedAt: !88)
!91 = !DILocation(line: 40, column: 5, scope: !23, inlinedAt: !88)
!92 = !DILocation(line: 41, column: 10, scope: !23, inlinedAt: !88)
!93 = !DILocation(line: 42, column: 10, scope: !23, inlinedAt: !88)
!94 = !DILocation(line: 43, column: 5, scope: !23, inlinedAt: !88)
!95 = !DILocation(line: 116, column: 5, scope: !78)
!96 = !DILocation(line: 37, column: 10, scope: !23, inlinedAt: !97)
!97 = distinct !DILocation(line: 120, column: 10, scope: !78)
!98 = !DILocation(line: 38, column: 10, scope: !23, inlinedAt: !97)
!99 = !DILocation(line: 39, column: 10, scope: !23, inlinedAt: !97)
!100 = !DILocation(line: 40, column: 5, scope: !23, inlinedAt: !97)
!101 = !DILocation(line: 41, column: 10, scope: !23, inlinedAt: !97)
!102 = !DILocation(line: 42, column: 10, scope: !23, inlinedAt: !97)
!103 = !DILocation(line: 43, column: 5, scope: !23, inlinedAt: !97)
!104 = !DILocation(line: 121, column: 5, scope: !78)
!105 = distinct !DISubprogram(name: "main", linkageName: "main", scope: null, file: !4, line: 123, type: !5, scopeLine: 123, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!106 = !DILocation(line: 37, column: 10, scope: !23, inlinedAt: !107)
!107 = distinct !DILocation(line: 128, column: 10, scope: !108)
!108 = !DILexicalBlockFile(scope: !105, file: !4, discriminator: 0)
!109 = !DILocation(line: 39, column: 10, scope: !23, inlinedAt: !107)
!110 = !DILocation(line: 40, column: 5, scope: !23, inlinedAt: !107)
!111 = !DILocation(line: 41, column: 10, scope: !23, inlinedAt: !107)
!112 = !DILocation(line: 42, column: 10, scope: !23, inlinedAt: !107)
!113 = !DILocation(line: 43, column: 5, scope: !23, inlinedAt: !107)
!114 = !DILocation(line: 21, column: 11, scope: !8, inlinedAt: !115)
!115 = distinct !DILocation(line: 130, column: 10, scope: !108)
!116 = !DILocation(line: 24, column: 11, scope: !8, inlinedAt: !115)
!117 = !DILocation(line: 25, column: 5, scope: !8, inlinedAt: !115)
!118 = !DILocation(line: 26, column: 11, scope: !8, inlinedAt: !115)
!119 = !DILocation(line: 27, column: 11, scope: !8, inlinedAt: !115)
!120 = !DILocation(line: 28, column: 5, scope: !8, inlinedAt: !115)
!121 = !DILocation(line: 38, column: 10, scope: !23, inlinedAt: !107)
!122 = !DILocation(line: 21, column: 11, scope: !8, inlinedAt: !123)
!123 = distinct !DILocation(line: 132, column: 10, scope: !108)
!124 = !DILocation(line: 24, column: 11, scope: !8, inlinedAt: !123)
!125 = !DILocation(line: 25, column: 5, scope: !8, inlinedAt: !123)
!126 = !DILocation(line: 26, column: 11, scope: !8, inlinedAt: !123)
!127 = !DILocation(line: 27, column: 11, scope: !8, inlinedAt: !123)
!128 = !DILocation(line: 28, column: 5, scope: !8, inlinedAt: !123)
!129 = !DILocation(line: 22, column: 11, scope: !8, inlinedAt: !115)
!130 = !DILocation(line: 22, column: 11, scope: !8, inlinedAt: !123)
!131 = !DILocation(line: 133, column: 10, scope: !108)
!132 = !DILocation(line: 134, column: 11, scope: !108)
!133 = !DILocation(line: 52, column: 10, scope: !33, inlinedAt: !134)
!134 = distinct !DILocation(line: 135, column: 11, scope: !108)
!135 = !DILocation(line: 53, column: 5, scope: !33, inlinedAt: !134)
!136 = !DILocation(line: 65, column: 11, scope: !33, inlinedAt: !134)
!137 = !DILocation(line: 137, column: 5, scope: !108)
!138 = !DILocation(line: 55, column: 10, scope: !33, inlinedAt: !134)
!139 = !DILocation(line: 59, column: 11, scope: !33, inlinedAt: !134)
!140 = !DILocation(line: 60, column: 11, scope: !33, inlinedAt: !134)
!141 = !DILocation(line: 84, column: 10, scope: !52, inlinedAt: !142)
!142 = distinct !DILocation(line: 136, column: 11, scope: !108)
!143 = !DILocation(line: 78, column: 10, scope: !47, inlinedAt: !144)
!144 = distinct !DILocation(line: 141, column: 11, scope: !108)
!145 = !DILocation(line: 79, column: 10, scope: !47, inlinedAt: !144)
!146 = !DILocation(line: 71, column: 10, scope: !42, inlinedAt: !147)
!147 = distinct !DILocation(line: 142, column: 11, scope: !108)
!148 = !DILocation(line: 72, column: 10, scope: !42, inlinedAt: !147)
!149 = !DILocation(line: 143, column: 11, scope: !108)
!150 = !DILocation(line: 37, column: 10, scope: !23, inlinedAt: !151)
!151 = distinct !DILocation(line: 144, column: 11, scope: !108)
!152 = !DILocation(line: 38, column: 10, scope: !23, inlinedAt: !151)
!153 = !DILocation(line: 39, column: 10, scope: !23, inlinedAt: !151)
!154 = !DILocation(line: 40, column: 5, scope: !23, inlinedAt: !151)
!155 = !DILocation(line: 41, column: 10, scope: !23, inlinedAt: !151)
!156 = !DILocation(line: 42, column: 10, scope: !23, inlinedAt: !151)
!157 = !DILocation(line: 43, column: 5, scope: !23, inlinedAt: !151)
!158 = !DILocation(line: 53, column: 5, scope: !33, inlinedAt: !159)
!159 = distinct !DILocation(line: 149, column: 11, scope: !108)
!160 = !DILocation(line: 52, column: 10, scope: !33, inlinedAt: !159)
!161 = !DILocation(line: 55, column: 10, scope: !33, inlinedAt: !159)
!162 = !DILocation(line: 59, column: 11, scope: !33, inlinedAt: !159)
!163 = !DILocation(line: 60, column: 11, scope: !33, inlinedAt: !159)
!164 = !DILocation(line: 65, column: 11, scope: !33, inlinedAt: !159)
!165 = !DILocation(line: 84, column: 10, scope: !52, inlinedAt: !166)
!166 = distinct !DILocation(line: 150, column: 11, scope: !108)
!167 = !DILocation(line: 151, column: 5, scope: !108)
!168 = !DILocation(line: 78, column: 10, scope: !47, inlinedAt: !169)
!169 = distinct !DILocation(line: 155, column: 11, scope: !108)
!170 = !DILocation(line: 79, column: 10, scope: !47, inlinedAt: !169)
!171 = !DILocation(line: 71, column: 10, scope: !42, inlinedAt: !172)
!172 = distinct !DILocation(line: 156, column: 11, scope: !108)
!173 = !DILocation(line: 72, column: 10, scope: !42, inlinedAt: !172)
!174 = !DILocation(line: 157, column: 11, scope: !108)
!175 = !DILocation(line: 37, column: 10, scope: !23, inlinedAt: !176)
!176 = distinct !DILocation(line: 158, column: 11, scope: !108)
!177 = !DILocation(line: 38, column: 10, scope: !23, inlinedAt: !176)
!178 = !DILocation(line: 39, column: 10, scope: !23, inlinedAt: !176)
!179 = !DILocation(line: 40, column: 5, scope: !23, inlinedAt: !176)
!180 = !DILocation(line: 41, column: 10, scope: !23, inlinedAt: !176)
!181 = !DILocation(line: 42, column: 10, scope: !23, inlinedAt: !176)
!182 = !DILocation(line: 43, column: 5, scope: !23, inlinedAt: !176)
!183 = !DILocation(line: 53, column: 5, scope: !33, inlinedAt: !184)
!184 = distinct !DILocation(line: 163, column: 11, scope: !108)
!185 = !DILocation(line: 52, column: 10, scope: !33, inlinedAt: !184)
!186 = !DILocation(line: 55, column: 10, scope: !33, inlinedAt: !184)
!187 = !DILocation(line: 59, column: 11, scope: !33, inlinedAt: !184)
!188 = !DILocation(line: 60, column: 11, scope: !33, inlinedAt: !184)
!189 = !DILocation(line: 65, column: 11, scope: !33, inlinedAt: !184)
!190 = !DILocation(line: 164, column: 11, scope: !108)
!191 = !DILocation(line: 52, column: 10, scope: !33, inlinedAt: !192)
!192 = distinct !DILocation(line: 165, column: 11, scope: !108)
!193 = !DILocation(line: 53, column: 5, scope: !33, inlinedAt: !192)
!194 = !DILocation(line: 55, column: 10, scope: !33, inlinedAt: !192)
!195 = !DILocation(line: 59, column: 11, scope: !33, inlinedAt: !192)
!196 = !DILocation(line: 60, column: 11, scope: !33, inlinedAt: !192)
!197 = !DILocation(line: 65, column: 11, scope: !33, inlinedAt: !192)
!198 = !DILocation(line: 166, column: 5, scope: !108)

