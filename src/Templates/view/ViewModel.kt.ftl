<#include "../commnt/file_package_improt.ftl">

import com.aac.module.model.AacViewModel

<#if  isHttp>
<#if dataType gt 0 >
import ${importPtah}.bean.${beanBean}
import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import android.content.Context
import com.alibaba.fastjson.TypeReference
import com.lzy.okgo.OkGo
import com.lzy.okgo.model.Response
import ${importJsonPath}
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

class ${name}ViewModel : AacViewModel() {
<#if isHttp>
<#if dataType==1>
    private val liveData = MutableLiveData<${beanBean}>()

    fun getData(context: Context, param: String): LiveData<${beanBean}> {
    OkGo.get<${beanBean}>("url").tag(context)
        .params("param", param)
        .execute(object : JsonCallback<${beanBean}>("s", ${beanBean}::class.java) {
            override fun onSuccess(response: Response<${beanBean}>) {
                liveData.value = response.body()
                }

                override fun onError(response: Response<${beanBean}>) {
                    super.onError(response)
                    liveData.value = null
                    }
                    })
                    return liveData
     }
<#elseif dataType==2>
    private val listData = MutableLiveData<List<${beanBean}>>()

    fun getListData(context: Context, param: String, page: Int): LiveData<List<${beanBean}>> {
       val typeReference = object : TypeReference<${beanBean}>(){}
       OkGo.get<List<${beanBean}>>("url")
           .tag(context)
           .params("param", param)
           .params("page", page)
           .execute(object : JsonCallback<List<${beanBean}>>("key", typeReference.type) {
               override fun onSuccess(response: Response<List<${beanBean}>>) {
                   listData.value = response.body()
                }

                override fun onError(response: Response<List<${beanBean}>>) {
                    super.onError(response)
                    listData.value = null
                }
       })
    return listData
    }
<#else >

</#if>
</#if>
    override fun onCleared() {
        super.onCleared()
    }

}