// /qt/qml/shared/Label.qml
#include <QtQml/qqmlprivate.h>
#include <QtCore/qdatetime.h>
#include <QtCore/qobject.h>
#include <QtCore/qstring.h>
#include <QtCore/qstringlist.h>
#include <QtCore/qtimezone.h>
#include <QtCore/qurl.h>
#include <QtCore/qvariant.h>
#include <QtQml/qjsengine.h>
#include <QtQml/qjsprimitivevalue.h>
#include <QtQml/qjsvalue.h>
#include <QtQml/qqmlcomponent.h>
#include <QtQml/qqmlcontext.h>
#include <QtQml/qqmlengine.h>
#include <QtQml/qqmllist.h>
#include <type_traits>
namespace QmlCacheGeneratedCode {
namespace _qt_qml_shared_Label_qml {
extern const unsigned char qmlData alignas(16) [];
extern const unsigned char qmlData alignas(16) [] = {

0x71,0x76,0x34,0x63,0x64,0x61,0x74,0x61,
0x3c,0x0,0x0,0x0,0x0,0x6,0x6,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x44,0x3,0x0,0x0,0x32,0x36,0x34,0x31,
0x30,0x39,0x37,0x38,0x62,0x37,0x33,0x38,
0x34,0x66,0x64,0x36,0x39,0x39,0x37,0x65,
0x63,0x32,0x34,0x37,0x34,0x64,0x32,0x38,
0x66,0x66,0x32,0x38,0x30,0x64,0x38,0x33,
0x64,0x63,0x65,0x38,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xcc,0x81,0x29,0x46,
0xa3,0xe6,0xa0,0xe8,0x8a,0xe7,0xfd,0xf4,
0x25,0xe8,0xf7,0x59,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x23,0x0,0x0,0x0,
0x8,0x0,0x0,0x0,0x60,0x1,0x0,0x0,
0x1,0x0,0x0,0x0,0xf8,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xfc,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xfc,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xfc,0x0,0x0,0x0,
0x2,0x0,0x0,0x0,0xfc,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x4,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x1,0x0,0x0,
0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x38,0x2,0x0,0x0,
0x10,0x1,0x0,0x0,0x43,0x0,0x0,0x0,
0x70,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x44,0x0,0x0,0x0,0x7,0x0,0x0,0x0,
0x6,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x1,0x0,
0xff,0xff,0xff,0xff,0x7,0x0,0x0,0x0,
0x8,0x0,0x50,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x7,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x8,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x2e,0x0,0x3c,0x1,
0x18,0x6,0x2,0x0,0x0,0x0,0x0,0x0,
0x80,0x1,0x0,0x0,0x88,0x1,0x0,0x0,
0xa0,0x1,0x0,0x0,0xb0,0x1,0x0,0x0,
0xd0,0x1,0x0,0x0,0xe8,0x1,0x0,0x0,
0xf8,0x1,0x0,0x0,0x28,0x2,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x7,0x0,0x0,0x0,0x51,0x0,0x74,0x0,
0x51,0x0,0x75,0x0,0x69,0x0,0x63,0x0,
0x6b,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x4,0x0,0x0,0x0,0x54,0x0,0x65,0x0,
0x78,0x0,0x74,0x0,0x0,0x0,0x0,0x0,
0xd,0x0,0x0,0x0,0x53,0x0,0x79,0x0,
0x73,0x0,0x74,0x0,0x65,0x0,0x6d,0x0,
0x50,0x0,0x61,0x0,0x6c,0x0,0x65,0x0,
0x74,0x0,0x74,0x0,0x65,0x0,0x0,0x0,
0x7,0x0,0x0,0x0,0x70,0x0,0x61,0x0,
0x6c,0x0,0x65,0x0,0x74,0x0,0x74,0x0,
0x65,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x5,0x0,0x0,0x0,0x63,0x0,0x6f,0x0,
0x6c,0x0,0x6f,0x0,0x72,0x0,0x0,0x0,
0x14,0x0,0x0,0x0,0x65,0x0,0x78,0x0,
0x70,0x0,0x72,0x0,0x65,0x0,0x73,0x0,
0x73,0x0,0x69,0x0,0x6f,0x0,0x6e,0x0,
0x20,0x0,0x66,0x0,0x6f,0x0,0x72,0x0,
0x20,0x0,0x63,0x0,0x6f,0x0,0x6c,0x0,
0x6f,0x0,0x72,0x0,0x0,0x0,0x0,0x0,
0x4,0x0,0x0,0x0,0x74,0x0,0x65,0x0,
0x78,0x0,0x74,0x0,0x0,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x10,0x0,0x0,0x0,
0x2,0x0,0x0,0x0,0x24,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x1,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x4,0x0,0x10,0x0,
0xff,0xff,0x0,0x0,0x2c,0x0,0x0,0x0,
0xb4,0x0,0x0,0x0,0x2,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff,
0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x0,0x0,0x2,0x0,0x54,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x84,0x0,0x0,0x0,
0x6,0x0,0x10,0x0,0x0,0x0,0x0,0x0,
0x84,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x84,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x5,0x0,0x0,0x0,0x0,0x0,0x7,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x8,0x0,0x50,0x0,0x8,0x0,0xc0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x8,0x0,
0x1,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x7,0x0,0x50,0x0,0x7,0x0,0x50,0x0,
0x0,0x0,0x0,0x0,0x3,0x0,0x0,0x0,
0x4,0x0,0x0,0x0,0x0,0x0,0xff,0xff,
0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x7,0x0,0x50,0x0,0x7,0x0,0x50,0x1,
0x54,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0
};
QT_WARNING_PUSH
QT_WARNING_DISABLE_MSVC(4573)

template <typename Binding>
void wrapCall(const QQmlPrivate::AOTCompiledContext *aotContext, void *dataPtr, void **argumentsPtr, Binding &&binding)
{
    using return_type = std::invoke_result_t<Binding, const QQmlPrivate::AOTCompiledContext *, void **>;
    if constexpr (std::is_same_v<return_type, void>) {
       Q_UNUSED(dataPtr)
       binding(aotContext, argumentsPtr);
    } else {
        if (dataPtr) {
           new (dataPtr) return_type(binding(aotContext, argumentsPtr));
        } else {
           binding(aotContext, argumentsPtr);
        }
    }
}
extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[] = {
{ 0, QMetaType::fromType<QVariant>(), {  }, 
    [](const QQmlPrivate::AOTCompiledContext *context, void *data, void **argv) {
        wrapCall(context, data, argv, [](const QQmlPrivate::AOTCompiledContext *aotContext, void **argumentsPtr) {
Q_UNUSED(aotContext)
Q_UNUSED(argumentsPtr)
// expression for color at line 8, column 5
QObject *r2_0;
QVariant r2_1;
// generate_LoadQmlContextPropertyLookup
while (!aotContext->loadContextIdLookup(0, &r2_0)) {
aotContext->setInstructionPointer(2);
aotContext->initLoadContextIdLookup(0);
if (aotContext->engine->hasError())
    return QVariant();
}
// generate_GetLookup
r2_1 = QVariant(aotContext->lookupResultMetaType(1));
while (!aotContext->getObjectLookup(1, r2_0, r2_1.data())) {
aotContext->setInstructionPointer(4);
aotContext->initGetObjectLookup(1, r2_0, r2_1.metaType());
if (aotContext->engine->hasError())
    return QVariant();
r2_1 = QVariant(aotContext->lookupResultMetaType(1));
}
// generate_Ret
if (!r2_1.isValid())
    aotContext->setReturnValueUndefined();
return r2_1;
});}
 },{ 0, QMetaType::fromType<void>(), {}, nullptr }};
QT_WARNING_POP
}
}